import 'ssc_button_style.dart';

typedef SSCButtonPropertyResolver<T> = T Function(Set<SSCButtonType> states);

abstract class SSCButtonStateProperty<T> {
  T resolve(Set<SSCButtonType> states);

  T resolveOne(SSCButtonType state);

  static T resolveAs<T>(T value, Set<SSCButtonType> states) {
    if (value is SSCButtonStateProperty<T>) {
      final SSCButtonStateProperty<T> property = value;
      return property.resolve(states);
    }
    return value;
  }

  static SSCButtonStateProperty<T> resolveWith<T>(
          SSCButtonPropertyResolver<T> callback) =>
      _SSCButtonTypePropertyWith<T>(callback);

  static SSCButtonStateProperty<T?>? lerp<T>(
    SSCButtonStateProperty<T>? a,
    SSCButtonStateProperty<T>? b,
    double t,
    T? Function(T?, T?, double) lerpFunction,
  ) {
    // Avoid creating a _LerpProperties object for a common case.
    if (a == null && b == null) {
      return null;
    }
    return _LerpProperties<T>(a, b, t, lerpFunction);
  }
}

class _LerpProperties<T> implements SSCButtonStateProperty<T?> {
  const _LerpProperties(this.a, this.b, this.t, this.lerpFunction);

  final SSCButtonStateProperty<T>? a;
  final SSCButtonStateProperty<T>? b;
  final double t;
  final T? Function(T?, T?, double) lerpFunction;

  @override
  T? resolve(Set<SSCButtonType> states) {
    final T? resolvedA = a?.resolve(states);
    final T? resolvedB = b?.resolve(states);
    return lerpFunction(resolvedA, resolvedB, t);
  }

  @override
  T? resolveOne(SSCButtonType state) {
    var states = [state];
    return resolve(states.toSet());
  }
}

class _SSCButtonTypePropertyWith<T> implements SSCButtonStateProperty<T> {
  final SSCButtonPropertyResolver<T> _resolve;

  _SSCButtonTypePropertyWith(this._resolve);

  @override
  T resolve(Set<SSCButtonType> states) => _resolve(states);

  @override
  T resolveOne(SSCButtonType state) {
    var states = [state];
    return _resolve(states.toSet());
  }
}
