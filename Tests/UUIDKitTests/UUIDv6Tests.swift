import Testing
@testable import UUIDKit

@Suite("UUIDv6 tests") struct UUIDv6Tests {
    @Test func variantAndVersion() {
        let uuid = UUID.v6()
        #expect(uuid.variant == .rfc4122)
        #expect(uuid.version == 6)
    }

    @Test func nodeIsRandom() {
        let uuid = UUID.v6()
        #expect(uuid.uuid.10 & 0x1 == 1)
    }

    @Test func nodeIsConstant() {
        let lhs = UUIDv6()
        let rhs = UUIDv6()
        #expect(lhs != rhs)
        #expect(lhs.node == rhs.node)
    }

    @Test func fields() {
        let uuid = UUIDv6("1efcb6ef-d587-6a90-b15f-537f6c98e2c2")
        #expect(uuid?.timestamp.rawValue == 0x1efcb6efd5870b0)
        #expect(uuid?.clockSequence.rawValue == 0x315f)
        #expect(uuid?.node.rawValue == 0x537f6c98e2c2)
    }

    @Test func rawRepresentable() {
        let rawValue = UUID(uuidString: "1efcb6ef-d587-6a90-b15f-537f6c98e2c2")!
        let uuid = UUIDv6(rawValue: rawValue)
        #expect(uuid != nil)
        #expect(uuid?.rawValue == rawValue)
        #expect(UUIDv6(rawValue: UUID(uuidString: "712869ea-f10f-40b7-b192-4f8653973806")!) == nil)
    }

    @Test func losslessStringConvertible() {
        let description = "1efcb6ef-d587-6a90-b15f-537f6c98e2c2"
        let uuid = UUIDv6(description)
        #expect(uuid != nil)
        #expect(uuid?.description.lowercased() == description)
        #expect(UUIDv6("712869ea-f10f-40b7-b192-4f8653973806") == nil)
    }
}
