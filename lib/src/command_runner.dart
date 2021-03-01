import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:dash_cli/src/commands/create.dart';
import 'package:dash_cli/src/flags.dart';
import 'package:io/io.dart';
import 'package:mason/mason.dart';

import 'version.dart';

const trackingId = "";
const applicationName = "";
const applicationVersion = version;

class DashCommandRunner extends CommandRunner<int> {
  DashCommandRunner({Logger logger})
      : _logger = logger ?? Logger(),
        super(
          "dash",
          "Command Line Interface tools to generate opinionated flutter project",
        ) {
    argParser
      ..addFlag(
        Version.full_name,
        negatable: false,
        abbr: Version.short_name,
        help: "Print the CLI version",
      );

    addCommand(CreateCommand());
  }

  final Logger _logger;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      _analyticsPrompt();
      final _argResults = parse(args);
      return await runCommand(_argResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      _logger
        ..err(e.message)
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version'] == true) {
      _logger.info('very_good version: $version');
      return ExitCode.success.code;
    }
    return super.runCommand(topLevelResults);
  }

  void _analyticsPrompt() {
    // TODO: Create CLI prompt for analytics
  }
}
