import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
import MuseScore 3.0

MuseScore {
   version: "3.0"
   description: "Adds brass fingering in a more configurable way"
   pluginType: "dialog"
   id: brassFingeringDeluxe
   menuPath: "Plugins.Brass Fingering Deluxe"

   requiresScore: true

   width: 200
   height: 220

   property bool breakLine: false
   property int noteShift: 0
   property var instrumentList: [ "Trumpet Bb", "Trumpet C", "Trombone", "Tuba", "Euphonium" ]
   property var valInstrument: "Trumpet Bb"

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
          brassFingeringDeluxe.title = "Brass Fingering Deluxe";
      }
   }

   Item {
        id: rect1
        anchors.fill: parent

        ColumnLayout {
            id: col1
            anchors.fill: parent

            ComboBox {
               id: selInstruments
               width: 200
               model: instrumentList
               onCurrentIndexChanged: onInstrumentSelect(currentIndex)
               anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {height: 4}

            CheckBox {
                id: optBreakLine
                text: "Break line"
                checked: false
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Rectangle {height: 2}
            RowLayout {
               anchors.horizontalCenter: parent.horizontalCenter
               Label {
                     text: "Note shift: "
               }
               SpinBox {
                     id: valNoteShift
                     implicitWidth: 45
                     horizontalAlignment: Qt.AlignRight
                     decimals: 0
                     minimumValue: -12
                     maximumValue: 12
                     value: 0
               }

            }

            Button {
               id: addButton
               text:"Add fingering"
               anchors.horizontalCenter: parent.horizontalCenter

               onClicked: {
                  var hasError = false;

                  // set configuration
                  breakLine = optBreakLine.checked;
                  noteShift = valNoteShift.value;

                  addFingering()
                  finish();
               }
            }

            Button {
               text: "Clean fingering"
               anchors {
                  top: addButton.bottom + 2
                  horizontalCenter: parent.horizontalCenter
               }
               onClicked: {
                  cleanFingering();
                  finish();
               }
            }

            // preserve user settings
            Settings {
                category: "BrassFingering"
                property alias valueBreakLine: optBreakLine.checked
                property alias valueNoteShift: valNoteShift.value
                property alias valueInstrumentSelect: selInstruments.currentIndex
            }
        }       
    }

   function finish() {
      if (mscoreMajorVersion < 4) {
         Qt.quit()
      }
   }



   function onInstrumentSelect(currentIndex) {
      valInstrument = instrumentList[currentIndex]
      if (valInstrument == "Trombone"){
         optBreakLine.enabled = false
         optBreakLine.opacity = 0.5;
      } else {
         optBreakLine.enabled = true
         optBreakLine.opacity = 1.0;
      }
   }

   function griff_trumpet(midi) {
      var lineBreak = breakLine ? "\n" : ""
      switch (midi){
         case 34: return "1"+lineBreak+"2"+lineBreak+"3"; break;
         case 35: return "1"+lineBreak+"3"; break;
         case 36: return "2"+lineBreak+"3"; break;
         case 37: return "1"+lineBreak+"2"; break;
         case 38: return "1"; break;
         case 39: return "2"; break;
         case 40: return "0"; break; //Bb Below Staff Treble
         case 41: return "1"+lineBreak+"2"+lineBreak+"3"; break; //B
         case 42: return "1"+lineBreak+"3"; break; //C
         case 43: return "2"+lineBreak+"3"; break; //C#
         case 44: return "1"+lineBreak+"2"; break; //D
         case 45: return "1"; break; //Eb
         case 46: return "2"; break; //E
         case 47: return "0"; break; //F
         case 48: return "2"+lineBreak+"3"; break; //F#
         case 49: return "1"+lineBreak+"2"; break; //G
         case 50: return "1"; break; //G#
         case 51: return "2"; break; //A
         case 52: return "0"; break; //Bb
         case 53: return "1"+lineBreak+"2"; break;
         case 54: return "1"; break;
         case 55: return "2"; break;
         case 56: return "0"; break;
         case 57: return "1"; break;
         case 58: return "2"; break;
         case 59: return "0"; break;
         case 60: return "2"+lineBreak+"3"; break;
         case 61: return "1"+lineBreak+"2"; break;
         case 62: return "1"; break;
         case 63: return "2"; break;
         case 64: return "0"; break;
         case 65: return "2"; break;
         case 66: return "1"; break;
         default: return "";
      }
   }

   function griff_trombone(midi) { 
         switch (midi){
            case 23: return "6"; break;//F
            case 24: return "5"; break;//Gb
            case 25: return "4"; break;//G
            case 26: return "3"; break;//Ab
            case 27: return "2"; break;//A
            case 28: return "1"; break;//Bb 2nd Line
            case 29: return "7"; break;//B
            case 30: return "6"; break;//C
            case 31: return "5"; break;//Db
            case 32: return "4"; break;//D
            case 33: return "3"; break;//Eb            
            case 34: return "2"; break;//E
            case 35: return "1"; break;//F
            case 36: return "5"; break;//Gb
            case 37: return "4"; break;//G
            case 38: return "3"; break;//Ab
            case 39: return "2"; break;//A
            case 40: return "1"; break;//Bb Top Staff Bass
            case 41: return "4"; break;//B
            case 42: return "3"; break;//C
            case 43: return "2"; break;//C#
            case 44: return "1"; break;//D
            case 45: return "3"; break;
            case 46: return "2"; break;
            case 47: return "1"; break;
            case 48: return "3"; break;
            case 49: return "2"; break;
            case 50: return "3"; break;
            case 51: return "1"; break;//Bb Above Staff Bass
            default: return "";			
         }
   }

   function griff_tuba(midi) {
      var lineBreak = breakLine ? "\n" : ""
      switch (midi){
         case 10: return "1"+lineBreak+"2"+lineBreak+"3"; break;
         case 11: return "1"+lineBreak+"3"; break;
         case 12: return "2"+lineBreak+"3"; break;
         case 13: return "1"+lineBreak+"2"; break;
         case 14: return "1"; break;
         case 15: return "2"; break;
         case 16: return "0"; break; //Bb below staff
         case 17: return "1"+lineBreak+"2"+lineBreak+"3"; break; //B
         case 18: return "1"+lineBreak+"3"; break; //C
         case 19: return "2"+lineBreak+"3"; break; //C#
         case 20: return "1"+lineBreak+"2"; break; //D
         case 21: return "1"; break; //Eb
         case 22: return "2"; break; //E
         case 23: return "0"; break; //F
         case 24: return "2"+lineBreak+"3"; break; //F#
         case 25: return "1"+lineBreak+"2"; break; //G
         case 26: return "1"; break; //G#
         case 27: return "2"; break; //A
         case 28: return "0"; break; //Bb 2nd line
         case 29: return "1"+lineBreak+"2"; break;
         case 30: return "1"; break;
         case 31: return "2"; break;
         case 32: return "0"; break;
         case 33: return "1"; break;
         case 34: return "2"; break;
         case 35: return "0"; break;
         case 36: return "2"+lineBreak+"3"; break;
         case 37: return "1"+lineBreak+"2"; break;
         case 38: return "1"; break;
         case 39: return "2"; break;
         case 40: return "0"; break;
         case 41: return "2"; break;
         case 42: return "1"; break;
         default: return "";			
      }
   }

   function griff_euphonium(midi) { 
      var lineBreak = breakLine ? "\n" : ""
      switch (midi){
         case 22: return "1"+lineBreak+"2"+lineBreak+"3"; break;
         case 23: return "1"+lineBreak+"3"; break;
         case 24: return "2"+lineBreak+"3"; break;
         case 25: return "1"+lineBreak+"2"; break;
         case 26: return "1"; break;
         case 27: return "2"; break;
         case 28: return "0"; break; //Bb 2nd Line
         case 29: return "1"+lineBreak+"2"+lineBreak+"3"; break; //B
         case 30: return "1"+lineBreak+"3"; break; //C
         case 31: return "2"+lineBreak+"3"; break; //C#
         case 32: return "1"+lineBreak+"2"; break; //D
         case 33: return "1"; break; //Eb
         case 34: return "2"; break; //E
         case 35: return "0"; break; //F
         case 36: return "2"+lineBreak+"3"; break; //F#
         case 37: return "1"+lineBreak+"2"; break; //G
         case 38: return "1"; break; //G#
         case 39: return "2"; break; //A
         case 40: return "0"; break; //Bb
         case 41: return "1"+lineBreak+"2"; break;
         case 42: return "1"; break;
         case 43: return "2"; break;
         case 44: return "0"; break;
         case 45: return "1"; break;
         case 46: return "2"; break;
         case 47: return "0"; break;
         case 48: return "2"+lineBreak+"3"; break;
         case 49: return "1"+lineBreak+"2"; break;
         case 50: return "1"; break;
         case 51: return "2"; break;
         case 52: return "0"; break;
         case 53: return "2"; break;
         case 54: return "1"; break;
         default: return "";			
      }
   }

   function griff(midi) { 
      midi = midi-20+noteShift;
      switch(valInstrument){
         case "Trumpet Bb": return griff_trumpet(midi+2);
         case "Trumpet C": return griff_trumpet(midi);
         case "Trombone": return griff_trombone(midi+2);
         case "Tuba": return griff_tuba(midi+2);
         case "Euphonium": return griff_euphonium(midi+2);
         default: return griff_trumpet(midi);
      }

   }

   function listProperty(item) {
      for (var p in item)
      {
         if( typeof item[p] != "function" )
               if(p != "objectName")
                  console.error(p + ":" + item[p]);
      }

   }

   function cleanFingering() {
      curScore.startCmd()
      var cursor   = curScore.newCursor();
      cursor.staffIdx = cursor.score.selection.startStaff;
      cursor.rewind(0);
      while (cursor.segment) {
         if (cursor.element && cursor.element.type == Element.CHORD && cursor.element.notes[0].elements) {
            var elements = cursor.element.notes[0].elements;
            for (var i=0; i<elements.length; i++) {
               if (elements[i].type==Element.FINGERING) {
                  cursor.element.notes[0].remove(elements[i]);
               }
            }
         }
         cursor.next();
      }
      curScore.endCmd()
   }

function addFingering() {
      cleanFingering()
      curScore.startCmd()
      var cursor   = curScore.newCursor();
      cursor.staffIdx = cursor.score.selection.startStaff;
      cursor.rewind(0);  // set cursor to first chord/rest
      while (cursor.segment) {
         if (cursor.element && cursor.element.type == Element.CHORD) {
            var text  = newElement(Element.FINGERING)
            var note = cursor.element.notes[0]
            text.text = griff(note.pitch)
            if (note.tieBack == null) cursor.add(text)
         }
         cursor.next();
      }
      curScore.endCmd()
      // quit();
   }

   onRun: {
   //   addFingering()
   }
}
