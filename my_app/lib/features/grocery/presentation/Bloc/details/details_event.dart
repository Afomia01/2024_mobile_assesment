import 'package:equatable/equatable.dart';

abstract class DetailsPageEvent extends Equatable {
  const DetailsPageEvent();

  @override
  List<Object> get props => [];
}

class FetchProductByIdEvent extends DetailsPageEvent {
  final String id;

  const FetchProductByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}
