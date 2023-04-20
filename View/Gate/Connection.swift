import SwiftUI

typealias ConnectionId = UUID

struct Connection: Identifiable {
    let id: ConnectionId = UUID()
    let from: GateId
    let to: GateId
    let toIndex: Int
}
