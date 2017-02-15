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
import StratifyLabs.UI 2.0

Flickable {
    id: control;
    property alias style: attr.style;
    property alias span: attr.span;
    property alias attr: attr;

    SSizeAttributes {
        id: attr;
        fillWidth: true;
        fillHeight: true;
    }

    clip: true;
    width: parent ? (attr.fillWidth ? parent.width : undefined) : undefined;
    height: parent ? (attr.fillHeight ? parent.height : undefined) : undefined;

    implicitWidth: contentWidth;
    implicitHeight: contentHeight;

    //if child has "fillWidth" set, width will bind
    contentWidth: ((contentItem.children[0].attr !== undefined) && (contentItem.children[0].attr.fillWidth === true)) ? control.width : contentItem.childrenRect.width;
    //if child has "fillHeight" set, height will bind
    //contentHeight: (contentItem.children[0].attr !== undefined) && (contentItem.children[0].attr.fillHeight === true) ? control.height : contentItem.childrenRect.height;
    contentHeight: (contentItem.children[0].attr !== undefined) && (contentItem.children[0].attr.fillHeight === true) ? control.height : contentItem.childrenRect.height;

}