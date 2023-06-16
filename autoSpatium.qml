import QtQuick 2.0
import MuseScore 3.0

MuseScore {
  menuPath: "Plugins.adjustSpatium"
  description: "Auto adjust spatium to make it fit one page."
  version: "1.0"

  property var step: 0.2
  property var nPages: 1

  function setSpatium(value){
    var style = curScore.style
    curScore.startCmd()
    style.setValue("spatium", value)
    curScore.endCmd()
  }

  onRun: {
    var start = 60
    var current = start
    setSpatium(start)
    while(curScore.npages > nPages){
      setSpatium(current-step)
      console.log(curScore.npages)
      current -= step
    }
    Qt.quit()
  }
}
