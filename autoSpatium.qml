import QtQuick 2.0
import MuseScore 3.0

MuseScore {
  menuPath: "Plugins.adjustSpatium"
  description: "Auto adjust spatium to make it fit one page."
  version: "1.0"

  property var step: 0.1
  property var nPages: 1

  function setStyle()
  {
    var style = curScore.style
    curScore.startCmd()
    // A4 landscape
    style.setValue("pageWidth", 11.6902)
    style.setValue("pageHeight", 6.69291)
    style.setValue("pagePrintableWidth", 11.2965)
    style.setValue("staffLowerBorder", 4)


    // Margin - 5mm and 0 in bottom
    style.setValue("pageTwosided", true)
    style.setValue("pageOddLeftMargin", 0.19685039370078738)
    style.setValue("pageOddTopMargin", 0.19685039370078738)
    style.setValue("pageOddBottomMargin", 0)
    style.setValue("pageEvenLeftMargin", 0.19685039370078738)
    style.setValue("pageEvenTopMargin", 0.19685039370078738)
    style.setValue("midClefKeyRightMargin", 1)
    style.setValue("clefKeyRightMargin", 0.8)
    style.setValue("pageEvenBottomMargin", 0)
    style.setValue("enableIndentationOnFirstSystem", 0)
    curScore.endCmd()
  }

  function log(msg) {
		if (true) {
			console.log(msg);
		}
	}

   function inspect(item) {
     console.log(item)
      for (var p in item) {
         if (typeof item[p] != "function")
            if (p != "objectName")
               console.error(p + ":" + item[p]);
      }	}

  function cleanTextBox(){
    var c=curScore.newCursor()
    var limiter = 100
    c.rewind(Cursor.SCORE_START)
    curScore.selection.select(c) //tackle weird range select problem
    cmd('prev-element')
    while( curScore.selection.elements[0].type!=Element.VBOX && limiter > 0){
        cmd('prev-element')
        limiter--;
    }
    if (limiter > 0){
      var e=curScore.selection.elements[0]
      cmd('select-similar')
      cmd('delete')
    }
  }

  function setSpatium(value){
    var style = curScore.style
    curScore.startCmd()
    style.setValue("spatium", value)
    curScore.endCmd()
  }

  function adjustSpatium(){
    var start = 60
    var current = start
    setSpatium(start)
    while(curScore.npages > nPages){
      setSpatium(current - step)
      current -= step
    }
  }

  onRun: {
    cleanTextBox()
    setStyle()
    adjustSpatium()
    Qt.quit()
  }
}
