import UIKit
import XCTest

class InputValidatorTests: XCTestCase {

    func testValidateReplacementStringWithEmailFormat() {
        let validation = Validation()
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"

        let validator = InputValidator(validation: validation)
        let text = "elvisnunez@me.co"
        XCTAssertTrue(validator.validateReplacementString("m", withText: text, withRange: NSRange(location: text.characters.count, length: text.characters.count)))
        XCTAssertFalse(validator.validateReplacementString("!", withText: text, withRange: NSRange(location: text.characters.count, length: text.characters.count)))
        XCTAssertTrue(validator.validateReplacementString("m", withText: text, withRange: NSRange(location: text.characters.count, length: 4)))
        XCTAssertFalse(validator.validateReplacementString("]", withText: text, withRange: NSRange(location: text.characters.count, length: 4)))
    }

    func testEmailFormatValidation() {
        let validation = Validation()
        validation.format = "[\\w._%+-]+@[\\w.-]+\\.\\w{2,}"

        let validator = InputValidator(validation: validation)
        XCTAssertTrue(validator.validateString("elvisnunez@me.com"))
        XCTAssertFalse(validator.validateString("elvisnunez[@]me.com"))
        XCTAssertFalse(validator.validateString("Elvis Nunez"))
    }

    func testMaximumLengthValidation() {
        let validation = Validation()
        validation.maximumLength = NSNumber(int: 5)

        let validator = InputValidator(validation: validation)
        XCTAssertTrue(validator.validateString("1234"))
        XCTAssertTrue(validator.validateString("12345"))
        XCTAssertFalse(validator.validateString("123456"))
    }

    func testMinimumLengthValidation() {
        let validation = Validation()
        validation.minimumLength = NSNumber(int: 5)

        let validator = InputValidator(validation: validation)
        XCTAssertFalse(validator.validateString("1234"))
        XCTAssertTrue(validator.validateString("12345"))
        XCTAssertTrue(validator.validateString("123456"))
    }

    func testBetweenLengthsValidation() {
        let validation = Validation()
        validation.minimumLength = NSNumber(int: 5)
        validation.maximumLength = NSNumber(int: 6)

        let validator = InputValidator(validation: validation)
        XCTAssertFalse(validator.validateString("1234"))
        XCTAssertTrue(validator.validateString("12345"))
        XCTAssertTrue(validator.validateString("123456"))
        XCTAssertFalse(validator.validateString("1234567"))
    }

    func testMaximumValueValidation() {
        let validation = Validation()
        validation.maximumValue = NSNumber(int: 100)

        let validator = InputValidator(validation: validation)
        XCTAssertTrue(validator.validateString("50"))
        XCTAssertTrue(validator.validateString("100"))
        XCTAssertFalse(validator.validateString("200"))
    }

    func testMinimumValueValidation() {
        let validation = Validation()
        validation.minimumValue = NSNumber(int: 100)

        let validator = InputValidator(validation: validation)
        XCTAssertFalse(validator.validateString("50"))
        XCTAssertTrue(validator.validateString("100"))
        XCTAssertTrue(validator.validateString("200"))
    }

    func testBetweenValuesValidation() {
        let validation = Validation()
        validation.minimumValue = NSNumber(int: 5)
        validation.maximumValue = NSNumber(int: 6)

        let validator = InputValidator(validation: validation)
        XCTAssertFalse(validator.validateString("4"))
        XCTAssertTrue(validator.validateString("5"))
        XCTAssertTrue(validator.validateString("6"))
        XCTAssertFalse(validator.validateString("7"))
    }

    func testRequiredValidation() {
        let validation = Validation()
        validation.required = true

        let validator = InputValidator(validation: validation)
        XCTAssertTrue(validator.validateString("12345"))
        XCTAssertFalse(validator.validateString(""))
    }
}
