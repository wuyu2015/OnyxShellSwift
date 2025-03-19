public protocol OnyxCommand {
    
    var parentCommand: OnyxCommand? { get set }
    var commandConfiguration: Onyx.CommandConfiguration? { get }
    
    static func main()
    static func main(arguments: [String]) -> OnyxCommand
    
    init()
    
    func handleParseError(error: Error)
    func handleSetupError(error: Error)
    func handleRunError(error: Error)
    mutating func setup() throws
    func run() throws
}
