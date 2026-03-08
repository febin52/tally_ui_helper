class TallyXmlBuilder {
  /// Builds an XML envelope for a Tally request.
  static String buildEnvelope({required String body}) {
    return '''<ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Export Data</TALLYREQUEST>
  </HEADER>
  <BODY>
    <EXPORTDATA>
      <REQUESTDESC>
        <REPORTNAME>$body</REPORTNAME>
        <STATICVARIABLES>
          <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
        </STATICVARIABLES>
      </REQUESTDESC>
    </EXPORTDATA>
  </BODY>
</ENVELOPE>''';
  }

  /// Builds a TDL XML request for extracting collections.
  static String buildCollectionRequest({
    required String collectionName,
    List<String>? fetchList,
    Map<String, String>? filters,
  }) {
    final fetchXml = fetchList != null
        ? fetchList.map((f) => '<FETCH>$f</FETCH>').join('\\n')
        : '<FETCH>*</FETCH>';

    return '''<ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Export Data</TALLYREQUEST>
  </HEADER>
  <BODY>
    <EXPORTDATA>
      <REQUESTDESC>
        <REPORTNAME>ODBC Report</REPORTNAME>
        <STATICVARIABLES>
          <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
        </STATICVARIABLES>
      </REQUESTDESC>
      <REQUESTDATA>
        <TALLYMESSAGE xmlns:UDF="TallyUDF">
          <COLLECTION NAME="$collectionName" ISINITIALIZE="Yes">
            <TYPE>$collectionName</TYPE>
            $fetchXml
          </COLLECTION>
        </TALLYMESSAGE>
      </REQUESTDATA>
    </EXPORTDATA>
  </BODY>
</ENVELOPE>''';
  }

  /// Builds an XML to import a voucher into Tally.
  static String buildVoucherImportXml(String voucherXml) {
    return '''<ENVELOPE>
  <HEADER>
    <TALLYREQUEST>Import Data</TALLYREQUEST>
  </HEADER>
  <BODY>
    <IMPORTDATA>
      <REQUESTDESC>
        <REPORTNAME>Vouchers</REPORTNAME>
        <STATICVARIABLES>
          <SVCURRENTCOMPANY>##SVCURRENTCOMPANY</SVCURRENTCOMPANY>
        </STATICVARIABLES>
      </REQUESTDESC>
      <REQUESTDATA>
        <TALLYMESSAGE xmlns:UDF="TallyUDF">
          $voucherXml
        </TALLYMESSAGE>
      </REQUESTDATA>
    </IMPORTDATA>
  </BODY>
</ENVELOPE>''';
  }
}
