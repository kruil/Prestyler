import XCTest
@testable import Prestyler


class Tests: XCTestCase {

    func testFindRules() {
        var text = "That is <b>a<b> text."
        var rules = Prestyler.findTextRules(&text)
        XCTAssert(rules[0].positions == [8,9])
        XCTAssert(text == "That is a text.")
        Prestyler.defineRule("*", UIColor.red)
        Prestyler.defineRule("^", UIColor.blue)
        text = "^text^ *743* ^text^ ^text^ *716979*"
        rules = Prestyler.findTextRules(&text)
        XCTAssert(text == "text 743 text text 716979")
        XCTAssert(rules.count == 2)
        XCTAssert(rules[0].positions == [5, 8, 19, 25])
        XCTAssert(rules[1].positions == [0, 4, 9, 13, 14, 18])
    }

    func testPrefilter() {
        let prefilteredNumbers = "text 743 text text 716979".prefilter(type: .numbers, by: "*")
        XCTAssert(prefilteredNumbers == "text *743* text text *716979*")
        let prefilteredTWord = "text 743 text text 716979".prefilter(text: "text", by: "^")
        XCTAssert(prefilteredTWord == "^text^ 743 ^text^ ^text^ 716979")
        let prefilteredBoth = "text 743 text text 716979"
            .prefilter(type: .numbers, by: "*")
            .prefilter(text: "text", by: "^")
        let prefilteredBothInvert = "text 743 text text 716979"
            .prefilter(text: "text", by: "^")
            .prefilter(type: .numbers, by: "*")
        XCTAssert(prefilteredBoth == "^text^ *743* ^text^ ^text^ *716979*")
        XCTAssert(prefilteredBoth == prefilteredBothInvert)
    }
    
    func testCorrectPositions() {
        var positions = [0,5,11,16,18,23]
        var rules = [TextRule(styles: [], positions: [7,10,25,31])]
        Prestyler.correctPositions(&positions, 1, &rules)
        XCTAssert(positions == [0,4,9,13,14,18])
        XCTAssert(rules[0].positions == [5,8,19,25])
    }
}
