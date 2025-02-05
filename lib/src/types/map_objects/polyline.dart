part of yandex_mapkit;

/// Collection of points connected by lines to be displayed on [YandexMap]
class Polyline extends Equatable implements MapObject {
  const Polyline({
    required this.mapId,
    required this.coordinates,
    this.isGeodesic = false,
    this.zIndex = 0.0,
    this.onTap,
    this.isVisible = true,
    this.strokeColor = const Color(0xFF0066FF),
    this.strokeWidth = 5.0,
    this.outlineColor = const Color(0x00000000),
    this.outlineWidth = 0.0,
    this.dashLength = 0.0,
    this.dashOffset = 0.0,
    this.gapLength = 0.0,
  });

  final List<Point> coordinates;
  final bool isGeodesic;
  final double zIndex;
  final TapCallback<Polyline>? onTap;

  /// Manages visibility of the object on the map.
  final bool isVisible;

  /// Stroke color.
  ///
  /// Setting the stroke color to any transparent color (i.e. RGBA code 0x00000000) effectively disables the stroke.
  final Color strokeColor;

  /// Stroke width in units.
  ///
  /// The size of a unit is equal to the size of a pixel at the current zoom
  /// with the camera position's tilt at 0 and a scale factor of 1
  final double strokeWidth;

  /// Outline color.
  ///
  /// Setting the color to any transparent color (i.e. RGBA code 0x00000000) effectively disables the outline.
  final Color outlineColor;

  /// Outline width in units.
  ///
  /// The size of a unit is equal to the size of a pixel at the current zoom
  /// with the camera position's tilt at 0 and a scale factor of 1
  final double outlineWidth;

  /// Length of a dash in units. Default: 0 (dashing is turned off).
  final double dashLength;

  /// Offset from the start of the polyline to the reference dash in units.
  final double dashOffset;

  /// Length of the gap between two dashes in units. Default: 0 (dashing is turned off).
  final double gapLength;

  Polyline copyWith({
    List<Point>? coordinates,
    bool? isGeodesic,
    double? zIndex,
    TapCallback<Polyline>? onTap,
    bool? isVisible,
    Color? strokeColor,
    double? strokeWidth,
    Color? outlineColor,
    double? outlineWidth,
    double? dashLength,
    double? dashOffset,
    double? gapLength,
  }) {
    return Polyline(
      mapId: mapId,
      coordinates: coordinates ?? this.coordinates,
      isGeodesic: isGeodesic ?? this.isGeodesic,
      zIndex: zIndex ?? this.zIndex,
      onTap: onTap ?? this.onTap,
      isVisible: isVisible ?? this.isVisible,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      outlineColor: outlineColor ?? this.outlineColor,
      outlineWidth: outlineWidth ?? this.outlineWidth,
      dashLength: dashLength ?? this.dashLength,
      dashOffset: dashOffset ?? this.dashOffset,
      gapLength: gapLength ?? this.gapLength,
    );
  }

  @override
  final MapObjectId mapId;

  @override
  Polyline clone() => copyWith();

  @override
  Polyline dup(MapObjectId mapId) {
    return Polyline(
      mapId: mapId,
      coordinates: coordinates,
      isGeodesic: isGeodesic,
      zIndex: zIndex,
      onTap: onTap,
      isVisible: isVisible,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      outlineColor: outlineColor,
      outlineWidth: outlineWidth,
      dashLength: dashLength,
      dashOffset: dashOffset,
      gapLength: gapLength,
    );
  }

  @override
  void _tap(Point point) {
    if (onTap != null) {
      onTap!(this, point);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': mapId.value,
      'coordinates': coordinates.map((Point p) => p.toJson()).toList(),
      'isGeodesic': isGeodesic,
      'zIndex': zIndex,
      'isVisible': isVisible,
      'strokeColor': strokeColor.value,
      'strokeWidth': strokeWidth,
      'outlineColor': outlineColor.value,
      'outlineWidth': outlineWidth,
      'dashLength': dashLength,
      'dashOffset': dashOffset,
      'gapLength': gapLength,
    };
  }

  @override
  Map<String, dynamic> _createJson() {
    return toJson()..addAll({
      'type': runtimeType.toString()
    });
  }

  @override
  Map<String, dynamic> _updateJson(MapObject previous) {
    assert(mapId == previous.mapId);

    return toJson()..addAll({
      'type': runtimeType.toString(),
    });
  }

  @override
  Map<String, dynamic> _removeJson() {
    return {
      'id': mapId.value,
      'type': runtimeType.toString()
    };
  }

  @override
  List<Object> get props => <Object>[
    mapId,
    coordinates,
    isGeodesic,
    zIndex,
    isVisible,
    strokeColor,
    strokeWidth,
    outlineColor,
    outlineWidth,
    dashLength,
    dashOffset,
    gapLength,
  ];

  @override
  bool get stringify => true;
}
