import benchy, pixie

let pathStr = "m57.611-8.591c-1.487,1.851-4.899,4.42-1.982,6.348,0.194,0.129,0.564,0.133,0.737-0.001,2.021-1.565,4.024-2.468,6.46-3.05,0.124-0.029,0.398,0.438,0.767,0.277,1.613-0.703,3.623-0.645,4.807-1.983,3.767,0.224,7.332-0.892,10.723-2.2,1.161-0.448,2.431-1.007,3.632-1.509,1.376-0.576,2.58-1.504,3.692-2.645,0.133-0.136,0.487-0.046,0.754-0.046-0.04-0.863,0.922-0.99,1.169-1.612,0.092-0.232-0.058-0.628,0.075-0.73,2.138-1.63,3.058-3.648,1.889-6.025-0.285-0.578-0.534-1.196-1.1-1.672-1.085-0.911-2.187-0.057-3.234-0.361-0.159,0.628-0.888,0.456-1.274,0.654-0.859,0.439-2.192-0.146-3.051,0.292-1.362,0.695-2.603,0.864-4.025,1.241-0.312,0.082-1.09-0.014-1.25,0.613-0.134-0.134-0.282-0.368-0.388-0.346-1.908,0.396-3.168,0.61-4.469,2.302-0.103,0.133-0.545-0.046-0.704,0.089-0.957,0.808-1.362,2.042-2.463,2.714-0.201,0.123-0.553-0.045-0.747,0.084-0.646,0.431-1.013,1.072-1.655,1.519-0.329,0.229-0.729-0.096-0.697-0.352,0.245-1.947,0.898-3.734,0.323-5.61,2.077-2.52,4.594-4.469,6.4-7.2,0.015-2.166,0.707-4.312,0.594-6.389-0.01-0.193-0.298-0.926-0.424-1.273-0.312-0.854,0.594-1.92-0.25-2.644-1.404-1.203-2.696-0.327-3.52,1.106-1.838,0.39-3.904,1.083-5.482-0.151-1.007-0.787-1.585-1.693-2.384-2.749-0.985-1.302-0.65-2.738-0.58-4.302,0.006-0.128-0.309-0.264-0.309-0.398,0.001-0.135,0.221-0.266,0.355-0.4-0.706-0.626-0.981-1.684-2-2,0.305-1.092-0.371-1.976-1.242-2.278-1.995-0.691-3.672,1.221-5.564,1.294-0.514,0.019-0.981-1.019-1.63-1.344-0.432-0.216-1.136-0.249-1.498,0.017-0.688,0.504-1.277,0.618-2.035,0.823-1.617,0.436-2.895,1.53-4.375,2.385-1.485,0.857-2.44,2.294-3.52,3.614-0.941,1.152-1.077,3.566,0.343,4.066,1.843,0.65,3.147-2.053,5.113-1.727,0.312,0.051,0.518,0.362,0.408,0.75,0.389,0.109,0.607-0.12,0.8-0.4,0.858,1.019,2.022,1.356,2.96,2.229,0.97,0.904,2.716,0.486,3.731,1.483,1.529,1.502,0.97,4.183,2.909,5.488-0.586,1.313-1.193,2.59-1.528,4.017-0.282,1.206,0.712,2.403,1.923,2.312,1.258-0.094,1.52-0.853,2.005-1.929,0.267,0.267,0.736,0.564,0.695,0.78-0.457,2.387-1.484,4.38-1.942,6.811-0.059,0.317-0.364,0.519-0.753,0.409-0.468,4.149-4.52,6.543-7.065,9.708-0.403,0.502-0.407,1.751,0.002,2.154,1.403,1.387,3.363-0.159,5.063-0.662,0.213-1.206,1.072-2.148,2.404-2.092,0.256,0.01,0.491-0.532,0.815-0.662,0.348-0.138,0.85,0.086,1.136-0.112,1.729-1.195,3.137-2.301,4.875-3.49,0.192-0.131,0.536,0.028,0.752-0.08,0.325-0.162,0.512-0.549,0.835-0.734,0.348-0.2,0.59,0.09,0.783,0.37-0.646,0.349-0.65,1.306-1.232,1.508-0.775,0.268-1.336,0.781-2.01,1.228-0.292,0.193-0.951-0.055-1.055,0.124-0.598,1.028-1.782,1.466-2.492,2.349z"

timeIt "parsePath":
  keep parsePath(pathStr)

block:
  let path = parsePath("""
    M 10,30
    A 20,20 0,0,1 50,30
    A 20,20 0,0,1 90,30
    Q 90,60 50,90
    Q 10,60 10,30 z
  """)
  timeIt "fillOverlaps":
    doAssert path.fillOverlaps(vec2(1, 1)) == false

const
  width = 500
  height = 300
  radius = 20

let paint = newPaint(SolidPaint)
paint.color = color(0, 0, 0, 0.5)

let rect = newPath()
rect.rect(10, 10, 480, 280)

let roundedRect = newPath()
roundedRect.roundedRect(10.5, 10.5, 479, 279, radius, radius, radius, radius)
# roundedRect.roundedRect(10, 10, 480, 280, radius, radius, radius, radius)

block:
  let image = newImage(width, height)

  timeIt "rect Image OverwriteBlend":
    paint.blendMode = OverwriteBlend
    image.fillPath(rect, paint)

  timeIt "rect Image NormalBlend":
    paint.blendMode = NormalBlend
    image.fillPath(rect, paint)

  timeIt "rect Image MaskBlend":
    paint.blendMode = MaskBlend
    image.fill(rgbx(255, 255, 255, 255))
    image.fillPath(rect, paint)

  timeIt "roundedRect Image OverwriteBlend":
    paint.blendMode = OverwriteBlend
    image.fillPath(roundedRect, paint)

  timeIt "roundedRect Image NormalBlend":
    paint.blendMode = NormalBlend
    image.fillPath(roundedRect, paint)

  timeIt "roundedRect Image MaskBlend":
    paint.blendMode = MaskBlend
    image.fill(rgbx(255, 255, 255, 255))
    image.fillPath(roundedRect, paint)

block:
  let mask = newMask(width, height)

  timeIt "rect Mask OverwriteBlend":
    mask.fillPath(rect, blendMode = OverwriteBlend)

  timeIt "rect Mask NormalBlend":
    mask.fillPath(rect, blendMode = NormalBlend)

  timeIt "rect Mask MaskBlend":
    mask.fill(255)
    mask.fillPath(rect, blendMode = MaskBlend)

  timeIt "rect Mask SubtractMaskBlend":
    mask.fill(255)
    mask.fillPath(rect, blendMode = SubtractMaskBlend)

  timeIt "rect Mask ExcludeMaskBlend":
    mask.fill(255)
    mask.fillPath(rect, blendMode = ExcludeMaskBlend)

  timeIt "roundedRect Mask OverwriteBlend":
    mask.fillPath(roundedRect, blendMode = OverwriteBlend)

  timeIt "roundedRect Mask NormalBlend":
    mask.fillPath(roundedRect, blendMode = NormalBlend)

  timeIt "roundedRect Mask MaskBlend":
    mask.fill(255)
    mask.fillPath(roundedRect, blendMode = MaskBlend)

  timeIt "roundedRect Mask SubtractMaskBlend":
    mask.fill(255)
    mask.fillPath(roundedRect, blendMode = SubtractMaskBlend)

  timeIt "roundedRect Mask ExcludeMaskBlend":
    mask.fill(255)
    mask.fillPath(roundedRect, blendMode = ExcludeMaskBlend)
