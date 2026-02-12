import Foundation

public enum BoboltChatTransportEvent: Sendable {
    case health(ok: Bool)
    case tick
    case chat(BoboltChatEventPayload)
    case agent(BoboltAgentEventPayload)
    case seqGap
}

public protocol BoboltChatTransport: Sendable {
    func requestHistory(sessionKey: String) async throws -> BoboltChatHistoryPayload
    func sendMessage(
        sessionKey: String,
        message: String,
        thinking: String,
        idempotencyKey: String,
        attachments: [BoboltChatAttachmentPayload]) async throws -> BoboltChatSendResponse

    func abortRun(sessionKey: String, runId: String) async throws
    func listSessions(limit: Int?) async throws -> BoboltChatSessionsListResponse

    func requestHealth(timeoutMs: Int) async throws -> Bool
    func events() -> AsyncStream<BoboltChatTransportEvent>

    func setActiveSessionKey(_ sessionKey: String) async throws
}

extension BoboltChatTransport {
    public func setActiveSessionKey(_: String) async throws {}

    public func abortRun(sessionKey _: String, runId _: String) async throws {
        throw NSError(
            domain: "BoboltChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "chat.abort not supported by this transport"])
    }

    public func listSessions(limit _: Int?) async throws -> BoboltChatSessionsListResponse {
        throw NSError(
            domain: "BoboltChatTransport",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "sessions.list not supported by this transport"])
    }
}
