class Motherboard {
  String name;
  String formFactor;
  String socket;
  String memoryType;
  int memorySlot;
  String sataType;
  int sataPorts;
  int fanPinType;
  String bus;

  Motherboard({
    required this.name,
    required this.formFactor,
    required this.socket,
    required this.memoryType,
    required this.memorySlot,
    required this.sataType,
    required this.sataPorts,
    required this.fanPinType,
    required this.bus
  });
}

class CPU {
  String name;
  String socket;

  CPU({
    required this.name,
    required this.socket
  });
}

class GPU {
  String name;
  String bus;

  GPU({
    required this.name,
    required this.bus
  });
}

class Storage {
  String name;
  String sataType;

  Storage({
    required this.name,
    required this.sataType
  });
}

class Fan {
  String name;
  int pinType;

  Fan({
    required this.name,
    required this.pinType
  });
}

class RAM {
  String name;
  String type;

  RAM({
    required this.name,
    required this.type
  });
}

class PSU {
  String name;
  String formFactor;

  PSU({
    required this.name,
    required this.formFactor
  });
}