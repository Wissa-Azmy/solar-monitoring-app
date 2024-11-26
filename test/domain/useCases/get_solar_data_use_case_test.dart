import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:solar_monitoring_app/data/DTOs/solar_data_dto.dart';
import 'package:solar_monitoring_app/data/common/api_resource.dart';
import 'package:solar_monitoring_app/data/repositories/solar_data_repository.dart';
import 'package:solar_monitoring_app/data/services/api_service.dart';
import 'package:solar_monitoring_app/data/services/cache_data_service.dart';
import 'package:solar_monitoring_app/data/services/solar_data_service.dart';
import 'package:solar_monitoring_app/domain/common/error_handling/external_error.dart';
import 'package:solar_monitoring_app/domain/common/extensions/date_time_extensions.dart';
import 'package:solar_monitoring_app/domain/models/monitoring_type.dart';
import 'package:solar_monitoring_app/domain/models/solar_data_model.dart';
import 'package:solar_monitoring_app/domain/repositories_protocols/solar_data_repository_protocol.dart';
import 'package:solar_monitoring_app/domain/use_cases/get_solar_data_use_case.dart';

import 'get_solar_data_use_case_test.mocks.dart';

@GenerateMocks([ApiServiceProtocol, CacheDataServiceProtocol])
void main() {
  // Dependencies
  late MockApiServiceProtocol mockApiService;
  late MockCacheDataServiceProtocol mockCacheDataService;
  late SolarDataServiceProtocol solarDataService;
  late SolarDataRepositoryProtocol solarDataRepository;
  late GetSolarDataUseCase useCase;

  // Input
  const type = MonitoringType.house;
  final date = DateTime(2024, 11, 25);
  final stringDate = date.stringDate;
  const isReloading = false;
  final cachingKey = '${type.name} $stringDate';
  final requestParameters = {'type': 'house', 'date': '2024-11-25'};

  // Stubs data
  final successJsonResponse = Response(
    '[{"timestamp": "2024-11-25 00:00:00.000", "value": 7123}]',
    200,
  );
  final failureJsonResponse = Response('', 500);
  final expectedDtos = [SolarDataDto(timestamp: date, value: 7123)];
  final expectedItems = [SolarDataModel(timestamp: date, value: 7123)];

  // Setup
  setUp(() {
    mockApiService = MockApiServiceProtocol();
    mockCacheDataService = MockCacheDataServiceProtocol();
    solarDataService = SolarDataService(apiService: mockApiService);
    solarDataRepository = SolarDataRepository(
      cacheDataService: mockCacheDataService,
      solarDataService: solarDataService,
    );
    useCase = GetSolarDataUseCase(solarDataRepo: solarDataRepository);
  });

  test('should return a list of SolarDataModel from the cache data service', () async {
    // Arrange
    when(
      mockCacheDataService.getData(cachingKey),
    ).thenAnswer((_) async => expectedDtos);

    // Act
    final result = await useCase.invoke(
      type: type,
      date: date,
      isReloading: isReloading,
    );

    // Assert
    expect(result, expectedItems);

    verify(
      mockCacheDataService.getData(cachingKey),
    ).called(1);
    verifyNever(
      mockApiService.sendGetRequest(
        ApiResource.monitoring,
        requestParameters,
      ),
    );
    verifyNoMoreInteractions(mockCacheDataService);
  });

  test('should return a list of SolarDataModel from the api data service', () async {
    // Arrange
    when(
      mockApiService.sendGetRequest(
        ApiResource.monitoring,
        requestParameters,
      ),
    ).thenAnswer((_) async => successJsonResponse);

    // Act
    final result = await useCase.invoke(
      type: type,
      date: date,
      isReloading: !isReloading,
    );

    // Assert
    expect(result, expectedItems);
    verify(
      mockApiService.sendGetRequest(
        ApiResource.monitoring,
        requestParameters,
      ),
    ).called(1);
    verifyNever(
      mockCacheDataService.getData(cachingKey),
    );
    verifyNoMoreInteractions(mockApiService);
  });

  test('should return a ServerError when the api data service returns error code 500', () async {
    // Arrange
    when(
      mockApiService.sendGetRequest(
        ApiResource.monitoring,
        requestParameters,
      ),
    ).thenAnswer((_) async => failureJsonResponse);

    // Act & Assert
    expect(
      () => useCase.invoke(
        type: type,
        date: date,
        isReloading: !isReloading,
      ),
      throwsA(ExternalError.serverError),
    );

    verify(
      mockApiService.sendGetRequest(
        ApiResource.monitoring,
        requestParameters,
      ),
    ).called(1);
    verifyNever(
      mockCacheDataService.getData(cachingKey),
    );
    verifyNoMoreInteractions(mockApiService);
  });
}
