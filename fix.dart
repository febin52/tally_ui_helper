import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (var file in files) {
    String content = file.readAsStringSync();

    // Fix string interpolations where \$ was incorrectly escaped
    content = content.replaceAll(r'\${', r'${');
    content = content.replaceAll(r'\$body', r'$body');
    content = content.replaceAll(r'\$f<', r'$f<');
    content = content.replaceAll(r'\$collectionName', r'$collectionName');
    content = content.replaceAll(r'\$fetchXml', r'$fetchXml');
    content = content.replaceAll(r'\$voucherXml', r'$voucherXml');
    content = content.replaceAll(r'\$e', r'$e');
    content = content.replaceAll(r'\$error', r'$error');
    content = content.replaceAll(r'\$_error', r'$_error');
    content = content.replaceAll(r'\$balanceType', r'$balanceType');

    // Fix const usage that became invalid after restoring interpolation
    content = content.replaceAll(
        "const Text('Error: \$error'", "Text('Error: \$error'");
    content = content.replaceAll("const Center(child: Text('Error: \$_error'))",
        "Center(child: Text('Error: \$_error'))");

    // Fix deprecated withOpacity
    content = content.replaceAllMapped(RegExp(r'\.withOpacity\((.*?)\)'),
        (m) => '.withValues(alpha: \${m[1]})');

    file.writeAsStringSync(content);
  }
}
