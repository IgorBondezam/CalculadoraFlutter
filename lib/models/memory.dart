class Memoria {
  static const operations = const ['%', '/', 'x', '-', '+', '='];

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  late String _operation;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand = '';

  String getValue(){
    return _value;
  }

  void applyCommand(String text) {
    if(_isReplacingOperation(text)) {
      _operation = text;
      return;
    }

    if(text == 'AC') {
      _clear();
    } else if(operations.contains(text)) {
      _setOperation(text);
    } else {
      _addDigit(text);
    }

    _lastCommand = text;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) 
      && operations.contains(command)
      && _lastCommand != '='
      && command != '=';
  }

  _setOperation(String newOperation) {
    bool isEqualSign = newOperation == '=';
    if(_bufferIndex == 0) {
      if(!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;
      
      _operation = isEqualSign ? '' : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }
    
    _wipeValue = true; // !isEqualSign;
  }

  _addDigit(String text) {
    final isDot = text == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if(isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + text;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
  }

  _clear() {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation;
    _wipeValue = false;
  }

  _calculate() {
    switch(_operation) {
      case '+': return _buffer[0] + _buffer[1];
      case '/': return _buffer[0] / _buffer[1];
      case '%': return _buffer[0] % _buffer[1];
      case '-': return _buffer[0] - _buffer[1];
      case 'x': return _buffer[0] * _buffer[1];
      default: return _buffer[0];
    }
  }
}