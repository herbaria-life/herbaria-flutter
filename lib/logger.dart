import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger getLogger(String className) {
  return Logger(printer: SimplePrinter(printTime: true, className: className));
}

/// Outputs simple log messages:
/// ```
/// [E] Time - ClassName - Log message ERROR: Error info
/// ```
class SimplePrinter extends LogPrinter {
  static final levelPrefixes = {
    Level.verbose: '[V]',
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
    Level.wtf: '[WTF]',
  };

  static final levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  final String className;
  final bool printTime;
  final bool colors;

  SimplePrinter(
      {this.printTime = false, this.colors = true, @required this.className});

  @override
  List<String> log(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    var timeStr = printTime ? '${DateTime.now().toIso8601String()}' : '';
    return [
      '${_labelFor(event.level)} $timeStr - $className - $messageStr$errorStr'
    ];
  }

  String _labelFor(Level level) {
    var prefix = levelPrefixes[level];
    var color = levelColors[level];

    return colors ? color(prefix) : prefix;
  }

  String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
