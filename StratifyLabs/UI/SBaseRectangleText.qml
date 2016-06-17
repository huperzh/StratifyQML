/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import QtQuick 2.6
import "."

SBaseRectangle {
    id: baseRectangleText;

    property string icon;
    property string text;
    property alias textObject: baseRectangleTextText;
    property bool hideTextOnSm: false;
    property bool spin: false;
    property bool pulse: false;
    property real pulseSteps: 8;
    property real animationPeriod: 1200;
    property alias iconObject: rectangleIcon;

    //size the rectangle based on the size of the text box
    implicitHeight: font_size + Theme.padding_base_vertical*3;
    implicitWidth: baseRectangleTextText.width;

    onSpinChanged: {
        if( spin == false ){
            rectangleIcon.rotation = 0;
        }
    }


    onStyleChanged: {
        var items = style.split(" ");
        for(var i=0; i < items.length; i++){
            if( items[i] === "text-left" ){
                baseRectangleTextText.anchors.centerIn = undefined;
                baseRectangleTextText.anchors.left = baseRectangleTextText.parent.left;
            } else if( items[i] === "text-right" ){
                baseRectangleTextText.horizontalAlignment = Text.AlightRight;
            } else if( items[i] === "text-center" ){
                baseRectangleTextText.horizontalAlignment = Text.AlignHCenter;
            } else if( items[i] === "bold" ){
                baseRectangleTextText.font.weight = Font.Bold;
            } else if( items[i] === "text-hide-sm"){
                hideTextOnSm = true;
            } else if( items[i] === "fa-spin" ){
                pulse = false;
                spin = true;
            } else if( items[i] === "fa-pulse" ){
                spin = false;
                pulse = true;
            }
        }
    }


    contents.data: [

        Row {
            id: baseRectangleTextText;
            anchors.centerIn: parent;

            leftPadding: padding_horizontal;
            rightPadding: padding_horizontal;
            bottomPadding: padding_vertical;
            topPadding: padding_vertical;
            spacing: Theme.padding_base_horizontal/4;

            Text {
                id: rectangleIcon;
                color: enabled ? text_color : Theme.text_muted;
                text: icon;
                font.pointSize: font_size*1.15;
                font.family: iconFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                height: rectangleText.height;

                RotationAnimation on rotation {
                    loops: Animation.Infinite;
                    paused: !spin;
                    from: 0;
                    to: 360;
                    duration: animationPeriod;
                }

                Timer {
                    id: pulseTimer;
                    running: pulse;
                    repeat: true;
                    interval: animationPeriod/pulseSteps;
                    onTriggered: {
                        rectangleIcon.rotation += 360/pulseSteps;
                    }
                }
            }

            Text {
                id: rectangleText;
                color: enabled ? text_color : Theme.text_muted;
                text: baseRectangleText.text;
                font.pointSize: font_size;
                font.family: textFont;
                font.weight: Font.Light;
                horizontalAlignment: Text.AlignHCenter;
                verticalAlignment: Text.AlignVCenter;
                visible: ((icon !== "") && (hideTextOnSm)) ? !sm : true;
            }
        }

    ]
}
