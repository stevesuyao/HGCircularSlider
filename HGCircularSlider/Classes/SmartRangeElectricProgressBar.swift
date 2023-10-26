//
//  SmartRangeElectricProgressBar.swift
//  HGCircularSlider
//
//  Created by Duc Do on 20/09/2023.
//  Copyright © 2023 intive. All rights reserved.
//

import UIKit

/**
 * A visual control used to select a single value from a continuous range of values.
 * Can also be used like a circular progress view
 * CircularSlider uses the target-action mechanism to report changes made during the course of editing:
 * ValueChanged, EditingDidBegin and EditingDidEnd
 */
@IBDesignable
open class SmartRangeElectricProgressBar: UIControl {
    
    // MARK: Changing the Slider’s Appearance
    
    /**
     * The color shown for the selected portion of the slider disk. (between start and end values)
     * The default value is a transparent color.
     */
    @IBInspectable
    open var diskFillColor: UIColor = .clear
    
    /**
     * The color shown for the unselected portion of the slider disk. (outside start and end values)
     * The default value of this property is the black color with alpha = 0.3.
     */
    @IBInspectable
    open var diskColor: UIColor = .gray
    
    /**
     * The color shown for the selected track portion. (between start and end values)
     * The default value of this property is the tint color.
     */
    @IBInspectable
    open var trackFillColor: UIColor = .clear

    /**
     * The color shown for the 2nd track portion. (between start and the 2nd end value)
     * The default value of this property is the tint color.
     */
    @IBInspectable
    open var secondTrackFillColor: UIColor = .clear
    
    /**
     * The color shown for the 2nd track portion. (between start and the 2nd end value)
     * The default value of this property is the tint color.
     */
    @IBInspectable
    open var secondTrackPowerFillColor: UIColor = .clear
    
    /**
     * The color shown for the 2nd track portion. (between start and the 2nd end value)
     * The default value of this property is the tint color.
     */
    @IBInspectable
    open var secondMainTrackFillColor: UIColor = .clear

    /**
     * The color shown for the 3rd track portion. (between the 2nd end value and the 1st end value)
     * The default value of this property is the tint color.
     */
    @IBInspectable
    open var thirdTrackFillColor: UIColor = .clear

    /**
     *
     */
    @IBInspectable
    open var secondTrackRadiusOffset: CGFloat = 36.0
    
    /**
     *
     */
    @IBInspectable
    open var thirdTrackRadiusOffset: CGFloat = 36.0
    
    /**
     * The color shown for the unselected track portion. (outside start and end values)
     * The default value of this property is the white color.
     */
    @IBInspectable
    open var trackColor: UIColor = .white
    
    /**
     * The width of the circular line
     *
     * The default value of this property is 5.0.
     */
    @IBInspectable
    open var lineWidth: CGFloat = 24.0
    
    /**
     * The width of the 2nd circular line
     *
     * The default value of this property is 5.0.
     */
    @IBInspectable
    open var secondTracklineWidth: CGFloat = 12.0
    
    /**
     * The width of the 2nd circular line
     *
     * The default value of this property is 5.0.
     */
    @IBInspectable
    open var secondMainTracklineWidth: CGFloat = 5.0
    
    /**
     * The width of the 2nd circular line
     *
     * The default value of this property is 5.0.
     */
    @IBInspectable
    open var thirdTrackLineWidth: CGFloat = 24.0

    /**
     * The width of the unselected track portion of the slider
     *
     * The default value of this property is 5.0.
     */
    @IBInspectable
    open var backtrackLineWidth: CGFloat = 17.0

    /**
     * The shadow offset of the slider
     *
     * The default value of this property is .zero.
     */
    @IBInspectable
    open var trackShadowOffset: CGPoint = .zero

    /**
     * The radius offset of the filled track
     *
     * The default value of this property is .zero.
     */
    @IBInspectable
    open var trackRadiusOffset: CGFloat = 0.0

    /**
     * The color of the shadow offset of the slider
     *
     * The default value of this property is .gray.
     */
    @IBInspectable
    open var trackShadowColor: UIColor = .gray

    /**
     * The width of the thumb stroke line
     *
     * The default value of this property is 4.0.
     */
    @IBInspectable
    open var thumbLineWidth: CGFloat = 4.0
    
    /**
     * The radius of the thumb
     *
     * The default value of this property is 13.0.
     */
    @IBInspectable
    open var thumbRadius: CGFloat = 0.0
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var sliderStartAngleFactor: CGFloat = 0.0
    
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var sliderEndAngleFactor: CGFloat = 2.0
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var sliderStartPowerAngleFactor: CGFloat = -1.25
    
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var sliderEndPowerAngleFactor: CGFloat = 1.25
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var fillTrackStartingFactor: CGFloat = -1.25
    
    /**
     *
     *
     * The default value of this property is
     */
    @IBInspectable
    open var fillTrackEndingFactor: CGFloat = 0.25

    /**
     *
     *
     * The default value of this property is 1.0
     */
    @IBInspectable
    open var trackMaxAngle: CGFloat = 1.0
    
    /**
     * The color used to tint the thumb
     * Ignored if the endThumbImage != nil
     *
     * The default value of this property is the groupTableViewBackgroundColor.
     */
    @IBInspectable
    open var endThumbTintColor: UIColor = .groupTableViewBackground
    
    /**
     * The stroke highlighted color of the end thumb
     * The default value of this property is blue
     */
    @IBInspectable
    open var endThumbStrokeHighlightedColor: UIColor = .blue
    
    /**
     * The color used to tint the stroke of the end thumb
     * Ignored if the endThumbImage != nil
     *
     * The default value of this property is red.
     */
    @IBInspectable
    open var endThumbStrokeColor: UIColor = .red
    
    /**
     * The image of the end thumb
     * Clears any custom color you may have provided for the end thumb.
     *
     * The default value of this property is nil
     */
    open var endThumbImage: UIImage?
    
    // MARK: Accessing the Slider’s Value Limits
    
    /**
     * Fixed number of rounds - how many circles has user to do to reach max value (like apple bedtime clock - which have 2)
     * the default value if this property is 1
     */
    @IBInspectable
    open var numberOfRounds: Int = 1 {
        didSet {
            assert(numberOfRounds > 0, "Number of rounds has to be positive value!")
            setNeedsDisplay()
        }
    }
    
    /**
     * The minimum value of the receiver.
     *
     * If you change the value of this property, and the end value of the receiver is below the new minimum, the end point value is adjusted to match the new minimum value automatically.
     * The default value of this property is 0.0.
     */
    @IBInspectable
    open var minimumValue: CGFloat = 0.0 {
        didSet {
            if endPointValue < minimumValue {
                endPointValue = minimumValue
            }
            if endPointValue2 < minimumValue {
                endPointValue2 = minimumValue
            }
        }
    }
    
    /**
     * The maximum value of the receiver.
     *
     * If you change the value of this property, and the end value of the receiver is above the new maximum, the end value is adjusted to match the new maximum value automatically.
     * The default value of this property is 1.0.
     */
    @IBInspectable
    open var maximumValue: CGFloat = 1.0 {
        didSet {
            if endPointValue > maximumValue {
                endPointValue = maximumValue
            }
            if endPointValue2 > maximumValue {
                endPointValue2 = maximumValue
            }
        }
    }

    /**
    * The offset of the thumb centre from the circle.
    *
    * You can use this to move the thumb inside or outside the circle of the slider
    * If the value is grather than 0 the thumb will be displayed outside the cirlce
    * And if the value is negative, the thumb will be displayed inside the circle
    */
    @IBInspectable
    open var thumbOffset: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    /**
     *
     *
     */
    @IBInspectable
    open var stopThumbAtMinMax: Bool = false
    
    /**
     *
     *
     */
    @IBInspectable
    open var enableRoundLineCap: Bool = false
    
    /**
     *
     *
     */
    @IBInspectable
    open var enableFirstTrackRoundLineCap: Bool = false

    /**
     *
     *
     */
    @IBInspectable
    open var enableSecondTrackRoundLineCap: Bool = false
    
    /**
    * Stop the thumb going beyond the min/max.
    *
    */
    @IBInspectable
    open var enableThridTrack: Bool = true


    /**
     * The value of the endThumb (changed when the user change the position of the end thumb)
     *
     * If you try to set a value that is above the maximum value, the property automatically resets to the maximum value.
     * And if you try to set a value that is below the minimum value, the property automatically resets  to the minimum value.
     *
     * The default value of this property is 0.5
     */
    open var endPointValue: CGFloat = 0.2 {
        didSet {
            if oldValue == endPointValue {
                return
            }
            if endPointValue > maximumValue {
                endPointValue = maximumValue
            }
            if endPointValue < minimumValue {
                endPointValue = minimumValue
            }

            setNeedsDisplay()
        }
    }
    
    /**
     *
     * The default value of this property is 0.5
     */
    open var endPointValue2: CGFloat = 0.25 {
        didSet {
            if oldValue == endPointValue2 {
                return
            }
            if endPointValue2 > maximumValue {
                endPointValue2 = maximumValue
            }
            if endPointValue2 < minimumValue {
                endPointValue2 = minimumValue
            }

            setNeedsDisplay()
        }
    }
    
    /**
     *
     * The default value of this property is 0.5
     */
    open var remainingPointValue: CGFloat = 0.25 {
        didSet {
            if oldValue == remainingPointValue {
                return
            }
            if remainingPointValue > maximumValue {
                remainingPointValue = maximumValue
            }
            if remainingPointValue < minimumValue {
                remainingPointValue = minimumValue
            }

            setNeedsDisplay()
        }
    }
    
    /**
     *
     * The default value of this property is 0.5
     */
    open var tripDistancePointValue: CGFloat = 0.25 {
        didSet {
            if oldValue == tripDistancePointValue {
                return
            }
            if tripDistancePointValue > maximumValue {
                tripDistancePointValue = maximumValue
            }
            if tripDistancePointValue < minimumValue {
                tripDistancePointValue = minimumValue
            }

            setNeedsDisplay()
        }
    }
    
    /**
     * The radius of circle
     */
    internal var radius: CGFloat {
        get {
            // the minimum between the height/2 and the width/2
            var radius =  min(bounds.center.x, bounds.center.y)
            
            // if we use an image for the thumb, the radius of the image will be used
            let maxThumbRadius = max(thumbRadius, (self.endThumbImage?.size.height ?? 0) / 2)

            // all elements should be inside the view rect, for that we should subtract the highest value between the radius of thumb and the line width
            radius -= max(lineWidth, (maxThumbRadius + thumbLineWidth + thumbOffset))
            return radius
        }
    }
    
    ///  See superclass documentation
    override open var isHighlighted: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: init methods
    
    /**
     See superclass documentation
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    /**
     See superclass documentation
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    internal func setup() {
        trackFillColor = tintColor
    }


    // MARK: Drawing methods
    
    /**
     See superclass documentation
     */
    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let valuesInterval = Interval(min: minimumValue, max: maximumValue, rounds: numberOfRounds)
        
        drawDistanceLine(context: context, valuesInterval: valuesInterval)
        
        drawPowerLine(context: context, valuesInterval: valuesInterval)
    }
    
    func drawDistanceLine(context: CGContext, valuesInterval: Interval) {
        drawCircularSlider(inContext: context)
        
        // get start angle from start value
        let startAngle = CircularSliderHelper.scaleToAngle(value: 0, inInterval: valuesInterval) + CircularSliderHelper.circleInitialAngle
        
        // get end angle from remaining value
        let endRemainingAngle = CircularSliderHelper.scaleToAngle(value: -remainingPointValue, inInterval: valuesInterval) + CircularSliderHelper.circleInitialAngle
        
        // get end angle from trip distance value
        let endTripDistanceAngle = CircularSliderHelper.scaleToAngle(value: -remainingPointValue - tripDistancePointValue, inInterval: valuesInterval) + CircularSliderHelper.circleInitialAngle
         
        drawFilledArc(fromAngle: startAngle, toAngle: endTripDistanceAngle, inContext: context)
        
        drawThirdFilledArc(fromAngle: startAngle, toAngle: endRemainingAngle, fillColor: thirdTrackFillColor, inContext: context)
    }
    
    func drawPowerLine(context: CGContext, valuesInterval: Interval) {
        let startAngle = fillTrackStartingFactor * CircularSliderHelper.pi

        let value = endPointValue * 0.75
        let value2 = endPointValue2 * 0.75
        
        // get end angle from end value
        let endAngle3 = CircularSliderHelper.scaleToAngle(value: value2, inInterval: valuesInterval) + fillTrackStartingFactor * CircularSliderHelper.pi
         
        let endAngle4 = CircularSliderHelper.scaleToAngle(value: value, inInterval: valuesInterval) + fillTrackStartingFactor * CircularSliderHelper.pi
         
        // draw second
        drawSecondFilledArc(fromAngle: startAngle, toAngle: fillTrackEndingFactor * CircularSliderHelper.pi,
                            fillColor: secondMainTrackFillColor, width: secondMainTracklineWidth, inContext: context)
        
        drawSecondFilledArc(fromAngle: startAngle, toAngle: endAngle3, fillColor: secondTrackPowerFillColor, width: secondTracklineWidth,
                            inContext: context)
        
        drawSecondFilledArc(fromAngle: startAngle, toAngle: endAngle4, fillColor: secondTrackFillColor, width: secondTracklineWidth,
                            inContext: context)
    }
    
    // MARK: User interaction methods
    
    /**
     See superclass documentation
     */
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        sendActions(for: .editingDidBegin)
        
        return true
    }

    // MARK: Utilities methods
    internal func newValue(from oldValue: CGFloat, touch touchPosition: CGPoint, start startPosition: CGPoint) -> CGFloat {
        let angle = CircularSliderHelper.angle(betweenFirstPoint: startPosition, secondPoint: touchPosition, inCircleWithCenter: bounds.center)
        let interval = Interval(min: minimumValue, max: maximumValue, rounds: numberOfRounds)
        let deltaValue = CircularSliderHelper.delta(in: interval, for: angle, oldValue: oldValue)
        
        var newValue = oldValue + deltaValue - minimumValue
        let range = maximumValue - minimumValue

        if !stopThumbAtMinMax {
            if newValue > maximumValue {
                newValue -= range
            }
            else if newValue < minimumValue {
                newValue += range
            }
        }

        return newValue
    }
}

extension SmartRangeElectricProgressBar {
    
    /**
     Draw arc with stroke mode (Stroke) or Disk (Fill) or both (FillStroke) mode
     FillStroke used by default
     
     - parameter arc:           the arc coordinates (origin, radius, start angle, end angle)
     - parameter lineWidth:     the with of the circle line (optional) by default 2px
     - parameter mode:          the mode of the path drawing (optional) by default FillStroke
     - parameter context:       the context
     
     */
    internal static func drawArc(withArc arc: Arc, lineWidth: CGFloat = 2, mode: CGPathDrawingMode = .fillStroke, inContext context: CGContext, squareLineCap: Bool = true, clockwise: Bool = false) {
        
        let circle = arc.circle
        let origin = circle.origin
        
        UIGraphicsPushContext(context)
        context.beginPath()
        
        context.setLineWidth(lineWidth)
        let lineCap = squareLineCap ? CGLineCap.square : CGLineCap.round
        context.setLineCap(lineCap)
        context.addArc(center: origin, radius: circle.radius, startAngle: arc.startAngle, endAngle: arc.endAngle, clockwise: clockwise)
        context.move(to: CGPoint(x: origin.x, y: origin.y))
        context.drawPath(using: mode)
        
        UIGraphicsPopContext()
    }
    
    /**
     Draw disk using arc coordinates
     
     - parameter arc:     the arc coordinates (origin, radius, start angle, end angle)
     - parameter context: the context
     */
    internal static func drawDisk(withArc arc: Arc, inContext context: CGContext, clockwise: Bool = false) {

        let circle = arc.circle
        let origin = circle.origin

        UIGraphicsPushContext(context)
        context.beginPath()

        context.setLineWidth(0)
        context.addArc(center: origin, radius: circle.radius, startAngle: arc.startAngle, endAngle: arc.endAngle, clockwise: clockwise)
        context.addLine(to: CGPoint(x: origin.x, y: origin.y))
        context.drawPath(using: .fill)

        UIGraphicsPopContext()
    }

    // MARK: drawing instance methods

    /// Draw the circular slider
    internal func drawCircularSlider(inContext context: CGContext) {
        diskColor.setFill()
        trackColor.setStroke()

        let circle = Circle(origin: bounds.center, radius: self.radius - secondTrackRadiusOffset - 3)
        let startAngle = sliderStartAngleFactor * CircularSliderHelper.pi
        let endAngle = sliderEndAngleFactor * CircularSliderHelper.pi
        CircularSliderHelper.circleTotalAngle = endAngle - startAngle
        let sliderArc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)
        SmartRangeElectricProgressBar.drawArc(withArc: sliderArc, lineWidth: backtrackLineWidth, inContext: context, squareLineCap: !enableRoundLineCap)
    }

    /// draw Filled arc between start an end angles
    internal func drawFilledArc(fromAngle startAngle: CGFloat, toAngle endAngle: CGFloat, inContext context: CGContext) {
        diskFillColor.setFill()
        trackFillColor.setStroke()

        let circle = Circle(origin: bounds.center, radius: self.radius - secondTrackRadiusOffset + trackRadiusOffset)
        let arc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)
        
        // fill Arc
        SmartRangeElectricProgressBar.drawDisk(withArc: arc, inContext: context, clockwise: true)
        // stroke Arc
        SmartRangeElectricProgressBar.drawArc(withArc: arc, lineWidth: lineWidth, mode: .stroke, inContext: context, squareLineCap: !enableFirstTrackRoundLineCap, clockwise: true)
    }
    
    /// draw the 2nd Filled arc between start an end angles
    internal func drawSecondFilledArc(fromAngle startAngle: CGFloat,
                                      toAngle endAngle: CGFloat,
                                      fillColor strokeColor: UIColor,
                                      width lineWidth: CGFloat,
                                      inContext context: CGContext) {
        strokeColor.setStroke()

        let circle = Circle(origin: bounds.center, radius: self.radius)
        let arc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)
        
        // stroke Arc
        SmartRangeElectricProgressBar.drawArc(withArc: arc, lineWidth: lineWidth, mode: .stroke, inContext: context, squareLineCap: !enableSecondTrackRoundLineCap)
    }
    
    /// draw the 2nd Filled arc between start an end angles
    internal func drawThirdFilledArc(fromAngle startAngle: CGFloat, toAngle endAngle: CGFloat, fillColor strokeColor: UIColor, inContext context: CGContext) {
        strokeColor.setStroke()

        let circle = Circle(origin: bounds.center, radius: self.radius - thirdTrackRadiusOffset)
        let arc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)
        
        // stroke Arc
        SmartRangeElectricProgressBar.drawArc(withArc: arc, lineWidth: thirdTrackLineWidth, mode: .stroke, inContext: context, squareLineCap: !enableSecondTrackRoundLineCap, clockwise: true)
    }

    internal func drawShadowArc(fromAngle startAngle: CGFloat, toAngle endAngle: CGFloat, inContext context: CGContext) {
        trackShadowColor.setStroke()

        let origin = CGPoint(x: bounds.center.x + trackShadowOffset.x, y: bounds.center.y + trackShadowOffset.y)
        let circle = Circle(origin: origin, radius: self.radius)
        let arc = Arc(circle: circle, startAngle: startAngle, endAngle: endAngle)

        // stroke Arc
        SmartRangeElectricProgressBar.drawArc(withArc: arc, lineWidth: lineWidth, mode: .stroke, inContext: context)
    }

    /**
     Draw the thumb and return the coordinates of its center
     
     - parameter angle:   the angle of the point in the main circle
     - parameter image:   the image of the thumb, if it's nil we use a disk (circle), the default value is nil
     - parameter context: the context
     
     - returns: return the origin point of the thumb
     */
    @discardableResult
    internal func drawThumbAt(_ angle: CGFloat, with image: UIImage? = nil, inContext context: CGContext) -> CGPoint {
        let circle = Circle(origin: bounds.center, radius: self.radius  - secondTrackRadiusOffset + self.thumbOffset)
        let thumbOrigin = CircularSliderHelper.endPoint(fromCircle: circle, angle: angle)
        
        if let image = image {
            return drawThumb(withImage: image, thumbOrigin: thumbOrigin, inContext: context)
        }
        
        // Draw a disk as thumb
        let thumbCircle = Circle(origin: thumbOrigin, radius: thumbRadius)
        let thumbArc = Arc(circle: thumbCircle, startAngle: CircularSliderHelper.circleMinValue, endAngle: CircularSliderHelper.circleMaxValue)

        SmartRangeElectricProgressBar.drawArc(withArc: thumbArc, lineWidth: thumbLineWidth, inContext: context)
        return thumbOrigin
    }

    /**
     Draw thumb using image and return the coordinates of its center

     - parameter image:   the image of the thumb
     - parameter angle:   the angle of the point in the main circle
     - parameter context: the context
     
     - returns: return the origin point of the thumb
     */
    @discardableResult
    private func drawThumb(withImage image: UIImage, thumbOrigin: CGPoint, inContext context: CGContext) -> CGPoint {
        UIGraphicsPushContext(context)
        context.beginPath()
        let imageSize = image.size
        let imageFrame = CGRect(x: thumbOrigin.x - (imageSize.width / 2), y: thumbOrigin.y - (imageSize.height / 2), width: imageSize.width, height: imageSize.height)
        image.draw(in: imageFrame)
        UIGraphicsPopContext()

        return thumbOrigin
    }
}


