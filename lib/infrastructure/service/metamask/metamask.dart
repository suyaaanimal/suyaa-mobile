import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:suyaa_mobile/infrastructure/service/metamask/suyaa.g.dart';
import 'package:web3_connect/web3_connect.dart';
import 'package:web3dart/web3dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

// TODO(__atah_atah):: 便宜上service層からぶち抜いてChangeNotifierにしている
class Metamask extends ChangeNotifier {
  final connection = Web3Connect();
  final contractAddress = '0x2fb924df038B03e883B39281A5b6fabeC358FdE5';
  final rpcURL = 'https://polygon-rpc.com/';
  final String deepLink =
      "wc:00e46b69-d0cc-4b3e-b6a2-cee442f97188@1?bridge=https%3A%2F%2Fbridge.walletconnect.org&key=91303dedf64285cbbaf9120f6e9d160a5c8aa3deb67017a3874cd272323f48ae";
  late final client = Web3Client(rpcURL, Client())..printErrors = true;
  late final contract =
      Suyaa(address: EthereumAddress.fromHex(contractAddress), client: client);
  bool signined = false;
  bool itemBuyed = false;

  connect() async {
    connection.enterChainId(80001);
    connection.enterRpcUrl(rpcURL);
    await connection.connect();
    if (connection.account != "") {
      signined = true;
      notifyListeners();
    }
  }

  _transaction(String functionName, List<dynamic> parameters) async {
    final function = contract.self.function(functionName);
    final transaction = Transaction.callContract(
      contract: contract.self,
      function: function,
      from: EthereumAddress.fromHex(connection.account),
      parameters: parameters,
    );
    final f = client.sendTransaction(connection.credentials, transaction,
        chainId: 80001);

    if (!await launchUrlString(deepLink)) {
      throw "Could not launch metamask";
    }
    await f;
    return transaction;
  }

  burn(int amount) async {
    await _transaction('burn', [BigInt.from(amount)]);
  }

  Future<int> balance() async {
    BigInt balance =
        await contract.balanceOf(EthereumAddress.fromHex(connection.account));
    return balance.toInt();
  }

  buyItem() {
    itemBuyed = true;
    notifyListeners();
  }
}
