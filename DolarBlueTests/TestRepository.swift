//
//  TestRepository.swift
//  DolarBlueTests
//
//  Created by Max Ward on 02/03/2023.
//

import XCTest

final class TestRepository: XCTestCase {

    var repository: CurrencyRepository!

    func testRemoteRequest() async throws {
        
        repository = CurrencyRepositoryDefault(remoteDataSource: CurrencyRemoteDataSource(),
                                               localDataSource: CurrencyLocalDataSoruce())
        
        do {
            guard let currencies = try await repository.fetchAll() else {
                throw APIError.emptyData
            }
            XCTAssert(currencies.count > 0, "Users array is empty")
        } catch {
            XCTFail("Failed to get users: \(error.localizedDescription)")
        }
    }
    
    func testEmptyDataRequest() async throws {
        let remoteDataSource = CurrencyRemoteMockDataSource(fileName: "currency_empty")
        repository = CurrencyRepositoryDefault(remoteDataSource: remoteDataSource,
                                               localDataSource: CurrencyLocalDataSoruce())
        do {
            if let currencies = try await repository.fetchAll() {
                XCTAssert(currencies.count == 0, "Users array is empty")
            }
        } catch {
            XCTFail("Failed to get users: \(error.localizedDescription)")
        }
    }
    
    func testServerError() async throws {
        
        let remoteDataSource = CurrencyRemoteMockDataSource(fileName: "currency_server_error")
        repository = CurrencyRepositoryDefault(remoteDataSource: remoteDataSource,
                                               localDataSource: CurrencyLocalDataSoruce())
        do {
            _ = try await repository.fetchAll()
            XCTFail("Query success")
        } catch {
            XCTAssertNotNil(error, "error is nil")
        }
    }

}
