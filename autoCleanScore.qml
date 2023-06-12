import QtQuick 2.0
import MuseScore 3.0

MuseScore {
    menuPath: "Plugins.pluginName"
    description: "Description goes here"
    version: "1.0"
    function cleanTextBox(){
        var c=curScore.newCursor()
        c.rewind(Cursor.SCORE_START)
        curScore.selection.select(c) //tackle weird range select problem
        cmd('prev-element')
        while( curScore.selection.elements[0].type!=Element.VBOX ){
            cmd('prev-element')
        }
        var e=curScore.selection.elements[0]
        removeElement(e)
    }
    onRun: {
        cleanTextBox()
        Qt.quit()
    }
    }
