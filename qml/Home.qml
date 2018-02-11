// Home.qml
//
// This file is part of the nCounter application.
//
// Copyright (c) 2017
//
// Maintained by Joe (@exar_kun) <joe@ubports.com>
//
// GNU GENERAL PUBLIC LICENSE
//    Version 3, 29 June 2007
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import Ubuntu.Components 1.3
import "modules"
import QtMultimedia 5.0
import Ubuntu.Components.Pickers 0.1
import "../assets/daySince.js" as Dater
import UserMetrics 0.1



Page {
    id: homePage
    title: i18n.tr("nCounter")
    header: DefaultHeader {}
    ScrollView {
        id: scroll
        anchors {
            fill: parent
            topMargin: homePage.header.height
        }


        Column {
            id: homeColumn
            width: scroll.width
            spacing: units.gu(2)



            Rectangle {
                id: spacer
                height: 20
                width: 20
            }


            DatePicker {
                anchors.horizontalCenter: parent.horizontalCenter
                id: eventDate
                minimum: {
                    var d = new Date();
                    d.setFullYear(d.getFullYear() - 100);
                    return d;
                }
                mode: "Years|Months|Days"
                date: new Date()
            }

	    DefaultLabel {
                 id: inputLabel
                 text: i18n.tr("Event to track:")
            }
   
            TextField {
                 id: event
                 text: settings.myEvent
                 anchors.horizontalCenter: parent.horizontalCenter
                 focus: true
             }
          
            Metric {
                property string circleMetric
                id: metric
                name: "nCounter"
                format: circleMetric
                emptyFormat: i18n.tr("Add nCounter")
                domain: "ncounter.joe"
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                id: saveDate
                text: i18n.tr("Track")
                property int theYear: settings.myDate.getFullYear()
                property int theMonth: settings.myDate.getMonth()
                property int theDay: settings.myDate.getDate()
                property string theEvent: settings.myEvent
                property string theFinal: Dater.daySince(theYear, theMonth, theDay)
                onClicked: {
                    settings.myEvent = event.text
                    settings.myDate = eventDate.date
                    metric.circleMetric = theFinal + " since " + theEvent
                    metric.update(0)
                }
            }

            DefaultLabel {
                property int theYear: settings.myDate.getFullYear()
                property int theMonth: settings.myDate.getMonth()
                property int theDay: settings.myDate.getDate()
                property string theEvent: settings.myEvent
                property string theFinal: Dater.daySince(theYear, theMonth, theDay)
                id: record
                text: theFinal + i18n.tr(" since ") + theEvent
                }

        }
    }
}
