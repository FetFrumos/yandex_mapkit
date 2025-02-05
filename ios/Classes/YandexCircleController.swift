import YandexMapsMobile

class YandexCircleController: NSObject, YandexMapObjectController {
  private let internallyControlled: Bool
  public let circle: YMKCircleMapObject
  private let tapListener: YandexMapObjectTapListener
  private unowned var controller: YandexMapController
  public let id: String

  public required init(
    parent: YMKMapObjectCollection,
    params: [String: Any],
    controller: YandexMapController
  ) {
    let circle = parent.addCircle(
      with: Utils.circleFromJson(params),
      stroke: Utils.uiColor(fromInt: (params["strokeColor"] as! NSNumber).int64Value),
      strokeWidth: (params["strokeWidth"] as! NSNumber).floatValue,
      fill: Utils.uiColor(fromInt: (params["fillColor"] as! NSNumber).int64Value)
    )

    self.circle = circle
    self.id = params["id"] as! String
    self.controller = controller
    self.tapListener = YandexMapObjectTapListener(id: id, controller: controller)
    self.internallyControlled = false

    super.init()

    circle.userData = self.id
    circle.addTapListener(with: tapListener)
    update(params)
  }

  public required init(
    circle: YMKCircleMapObject,
    params: [String: Any],
    controller: YandexMapController
  ) {
    self.circle = circle
    self.id = params["id"] as! String
    self.controller = controller
    self.tapListener = YandexMapObjectTapListener(id: id, controller: controller)
    self.internallyControlled = true

    super.init()

    circle.userData = self.id
    circle.addTapListener(with: tapListener)
    update(params)
  }

  public func update(_ params: [String: Any]) {
    circle.geometry = Utils.circleFromJson(params)
    circle.isGeodesic = (params["isGeodesic"] as! NSNumber).boolValue
    circle.zIndex = (params["zIndex"] as! NSNumber).floatValue
    circle.isVisible = (params["isVisible"] as! NSNumber).boolValue
    circle.strokeColor = Utils.uiColor(fromInt: (params["strokeColor"] as! NSNumber).int64Value)
    circle.strokeWidth = (params["strokeWidth"] as! NSNumber).floatValue
    circle.fillColor = Utils.uiColor(fromInt: (params["fillColor"] as! NSNumber).int64Value)
  }

  public func remove() {
    if (internallyControlled) {
      return
    }

    circle.parent.remove(with: circle)
  }
}
