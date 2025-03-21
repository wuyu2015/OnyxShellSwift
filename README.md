# OnyxShell

`OnyxShell` 是一个功能完整的用于解析命令行参数的 Swift 库，帮助开发者以优雅的方式构建强大的命令行工具。

## 特性

- 提供 4 个属性包装器：`@Argument`、`@Flag`、`@Option`、`@Value`
- 支持多层级子命令
- 支持解析以下类型的命令行参数：`String`、`Int`、`Double`、`Bool`、`[String]`、`[Int]`、`[Double]`、`[Bool]`、`[String: String]`

## 使用

```swift
import OnyxShell

struct DemoCommand: OnyxCommand {
    var parentCommand: OnyxCommand?
    let commandConfiguration: Onyx.CommandConfiguration? = .init(
        name: "demo",
        usage: """
            [-c | --counter | -C | --no-counter]
            [--repeat=<count> | -n <count>]
            [<name>]
            """,
        helpText: """
            这是一个演示命令，用于展示如何使用 OnyxShell 来解析命令行参数。

            参数：
            -c, --counter           启用计数器功能。每行输出将包含计数器。
            -C, --no-counter        禁用计数器功能。输出将不包含计数器。

            --repeat=<count>，
            -n <count>              指定输出的重复次数，默认为 3。

            <name>                  要在输出中打印的名称。
            """
    )
    
    @Value(default: false)
    var useCounter: Bool?
    
    @Flag(true, ref: "useCounter", aliases: ["c"])
    var counter: Bool?
    
    @Flag(false, ref: "useCounter", aliases: ["C"])
    var noCounter: Bool?
    
    @Option(name: "repeat", shortName: "n", default: 3, required: true)
    var count: Int?
    
    @Argument var name: String?
    
    func run() throws {
        if let name = name {
            if useCounter! {
                for i in 0..<count! {
                    print("\(i + 1): Hi, \(name.capitalized)")
                }
            } else {
                for _ in 0..<count! {
                    print("Hi, \(name.capitalized)")
                }
            }
        }
    }
}

DemoCommand.main()
```

### 输出

```bash
$ demo alice
Hi, Alice
Hi, Alice
Hi, Alice
$ demo -c --repeat 5 bob
1: Hi, Bob
2: Hi, Bob
3: Hi, Bob
4: Hi, Bob
5: Hi, Bob
```

## 安装

您可以使用 Swift Package Manager 将 `OnyxShell` 集成到您的 Xcode 项目中：

1. 在 Xcode 中，选择 "File" -> "Swift Packages" -> "Add Package Dependency..."
2. 输入此 URL：`https://github.com/wuyu2015/OnyxShellSwift`
3. 按照提示完成集成过程。

### 或

```
.package(url: "https://github.com/wuyu2015/OnyxShellSwift", from: "0.1.0")
```

## 许可证

MIT License

---

# OnyxShell

`OnyxShell` is a Swift library for parsing command-line arguments, helping developers build powerful command-line tools in an elegant way.

## Features

- Provides 4 property wrappers: `@Argument`, `@Flag`, `@Option`, `@Value`
- Supports multi-level subcommands
- Supports parsing the following types of command-line arguments: `String`, `Int`, `Double`, `Bool`, `[String]`, `[Int]`, `[Double]`, `[Bool]`, `[String: String]`

## Usage

```swift
import OnyxShell

struct DemoCommand: OnyxCommand {
    var parentCommand: OnyxCommand?
    let commandConfiguration: Onyx.CommandConfiguration? = .init(
        name: "demo",
        usage: """
            [-c | --counter | -C | --no-counter]
            [--repeat=<count> | -n <count>]
            [<name>]
            """,
        helpText: """
            This is a demo command that demonstrates how to use OnyxShell to parse command-line arguments.

            Arguments:
            -c, --counter           Enable the counter feature. Each output will include an incrementing counter.
            -C, --no-counter        Disable the counter feature. Outputs will not include a counter.

            --repeat=<count>,
            -n <count>              Specify the number of times the output should repeat. Default is 3.

            <name>                  The name to be printed in the output.
            """
    )
    
    @Value(default: false)
    var useCounter: Bool?
    
    @Flag(true, ref: "useCounter", aliases: ["c"])
    var counter: Bool?
    
    @Flag(false, ref: "useCounter", aliases: ["C"])
    var noCounter: Bool?
    
    @Option(name: "repeat", shortName: "n", default: 3, required: true)
    var count: Int?
    
    @Argument var name: String?
    
    func run() throws {
        if let name = name {
            if useCounter! {
                for i in 0..<count! {
                    print("\(i + 1): Hi, \(name.capitalized)")
                }
            } else {
                for _ in 0..<count! {
                    print("Hi, \(name.capitalized)")
                }
            }
        }
    }
}

DemoCommand.main()
```

### Output

```bash
$ demo alice
Hi, Alice
Hi, Alice
Hi, Alice
$ demo -c --repeat 5 bob
1: Hi, Bob
2: Hi, Bob
3: Hi, Bob
4: Hi, Bob
5: Hi, Bob
```

## Installation

You can integrate `OnyxShell` into your Xcode project using Swift Package Manager:

1. In Xcode, select "File" -> "Swift Packages" -> "Add Package Dependency..."
2. Enter this URL: `https://github.com/wuyu2015/OnyxShellSwift`
3. Follow the prompts to complete the integration process.

### Or

```
.package(url: "https://github.com/wuyu2015/OnyxShellSwift", from: "0.1.0")
```

## License

MIT License
