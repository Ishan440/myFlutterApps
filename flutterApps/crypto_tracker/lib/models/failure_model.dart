import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  // unlike the coin class, the constructor argument is optional so it must
  // be set to some default value.
  const Failure({this.message = ''});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
