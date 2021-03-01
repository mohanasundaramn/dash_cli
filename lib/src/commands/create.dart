import 'package:args/command_runner.dart';
import 'package:io/io.dart';

class CreateCommand extends Command<int> {
  @override
  String get description => "Creates new flutter starter project";

  @override
  String get name => "create";

  @override
  Future<int> run() async {
    return ExitCode.success.code;
  }
}
