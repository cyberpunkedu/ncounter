// Settings.qml
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
import Ubuntu.Components.Pickers 1.3
import UserMetrics 0.1



Page {
    id: settingsPage
    title: i18n.tr("nCounter")
    header: DefaultHeader {}
    ScrollView {
        id: scroll
        anchors {
            fill: parent
            topMargin: settingsPage.header.height
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

            DefaultLabel {
                 id: inputDate
                 text: i18n.tr("Event Name & Date:")
            }

            TextField {
                 id: event
                 placeholderText: i18n.tr("Input event name")
                 text: settings.myEvent
                 anchors.horizontalCenter: parent.horizontalCenter
                 focus: true
             }

            DatePicker {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 250
                id: eventDate
                minimum: {
                    var d = new Date();
                    d.setFullYear(d.getFullYear() - 100);
                    return d;
                }
                mode: "Years|Months|Days"
                date: new Date()
            }

            Metric {
                property string circleMetric
                id: metric
                name: "nCounter"
                format: circleMetric
                emptyFormat: i18n.tr("Check nCounter")
                domain: "ncounter.joe"
            }

            CalcDays {
                id: dateSaved
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                id: saveDate
                text: (settings.myEvent == 0) ? i18n.tr("Track") : i18n.tr("Update")
                color: UbuntuColors.orange
                onClicked: {
                    (settings.myEvent == event.text && settings.myReport == dateSaved.report) ? settings.restarts += 1 : settings.restarts = 0;
                    (settings.lastEvent == event.text) ? settings.myLast = dateSaved.report : settings.myLast = 0 , settings.lastEvent = event.text;
                    settings.myEvent = event.text
                    settings.myDate = eventDate.date
                    settings.myReport = dateSaved.report
                    metric.circleMetric = dateSaved.report
                    metric.update(0)
                    console.log("nCounter event updated\n")
                }
            }

            DefaultLabel {
                id: record
                text: (settings.myEvent == 0) ? i18n.tr("Add event above"): dateSaved.report + " ago"
            }

            DefaultLabel {
                id: previous
                visible: (settings.myLast == 0) ? false : true
                text: i18n.tr("Previous ") + settings.myLast
            }

            DefaultLabel {
                id: falseStart
                visible: (settings.restarts == 0) ? false : true
                text: i18n.tr("Restarts: ") + settings.restarts
            }

            DefaultLabel {
                id: resetNotice
                visible: (settings.restarts == 0) ? false : true
                text: i18n.tr("To completely start over, delete the event name and press 'Update'")
            }

        }
    }
}
