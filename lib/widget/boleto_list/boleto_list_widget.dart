import 'package:flutter/material.dart';

import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/widget/boleto_list/boleto_list_controller.dart';
import 'package:payflow/widget/boleto_tile/boleto_tile.widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;
  BoletoListWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, values, __) => Column(
        children: values
            .map((e) => BoletoTileWidget(
                  data: e,
                ))
            .toList(),
      ),
    );
  }
}
