import strformat

type
  Mof = object
    think: bool
    eyes: string
    message: string

proc say(mof: Mof): string =

  let thoughts = if mof.think: "o" else: "\\"

  let bubble = fmt"""
  ________________________
<           {mof.message}           >
  ------------------------"""

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

  return bubble & "\n" & donusagiAscii

proc main(think=false, eyes="_-", message: seq[string]): int =
  let mof = Mof(
    think: think,
    eyes: eyes,
    message: message[0],
  )
  echo say(mof)
  return 0

when isMainModule:
  import cligen
  dispatch(main, doc = "generates an ASCII picture of a donusagi saying something provided by the user")
