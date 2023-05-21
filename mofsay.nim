import strformat, strutils, eastasianwidth

type
  Mof = object
    think: bool
    eyes: string
    message: seq[string]

proc maxLength(args: seq[string]): int =
  var max = -1

  for arg in args:

    let len = arg.stringWidth
    if len > max:
      max = len

  return max

proc constructBalloon(mof: Mof): seq[string] =
  let max = maxLength(mof.message)
  let max2 = max + 2

  var border: seq[string]

  if mof.think:
    border = @["(", ")","(", ")","(", ")"]
  elif mof.message.len < 2:
    border = @["<", ">"]
  else:
    border = @["/", "\\", "\\", "/", "|", "|"]

  var balloonLines: seq[string] = @[]
  balloonLines.add(" " & repeat("_", max2) & " ")

  balloonLines.add(border[0] & " " & mof.message[0] & repeat(' ', max - mof.message[0].stringWidth) & " " & border[1])
  if mof.message.len >= 2:
    for line in mof.message[1 ..< mof.message.len - 1]:
      balloonLines.add(border[4] & " " & line & repeat(' ', max - line.stringWidth) & " " & border[5])
    balloonLines.add(border[2] & " " & mof.message[^1] & repeat(' ', max - mof.message[^1].stringWidth) & " " & border[3])

  balloonLines.add(" " & repeat("-", max2) & " ")

  return balloonLines

proc say(mof: Mof): string =
  let thoughts = if mof.think: "o" else: "\\"

  for line in constructBalloon(mof):
    echo line

  let donusagiAscii = fmt"""
    {thoughts}
     {thoughts}       /'\     /'\
      {thoughts}      ▏/\\   // \\
       {thoughts}    ▕ ▏ \\  ▏▏ |▕
        {thoughts}   ▕ \ ||  \\ |▕
         {thoughts}   \ \||   \\//
          {thoughts}   \ ' ''''  `-.
            /             `\
           /     {mof.eyes[0]}    ▁  {mof.eyes[1]}  \
          ;          ▟▙▙     \
          :         ◟_/\_/   ;
          \                  ;
           \           -   ,'
           ,'-...______.┄=' `'.
         /'     ___   \_/      \
               (___)  /'\
                      ▏ ▕
                      \ /
                       `
  """

  return donusagiAscii

proc main(think=false, eyes="_-", args: seq[string]): int =
  let mof = Mof(
    think: think,
    eyes: eyes,
    message: args,
  )
  echo say(mof)
  return 0

when isMainModule:
  import cligen
  dispatch(main, doc = "generates an ASCII picture of a donusagi saying something provided by the user")
