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

            // Metric to display on lock screen
            Metric {
                property string circleMetric
                id: metric
                name: "nCounter"
                format: circleMetric
                emptyFormat: i18n.tr("Check nCounter")
                domain: "ncounter.joe"
            }

            // Refers to CalcDays module
            CalcDays{
                id: updateReport
            }

            // Displays nCounter on Home Page
            DefaultLabel {
                id: showCounter
                font.pixelSize: 70
                text: (settings.myEvent == 0) ? i18n.tr("Add event to start counting") : settings.myReport + " ago";
                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: {
                        settings.myReport = updateReport.report
                        metric.circleMetric = updateReport.report
                        metric.update(0)
                        console.log("nCounter metric updated by timer\n")
                    }
                }
            }

            // Displays last counter if applicable
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

            Button {
               anchors.horizontalCenter: parent.horizontalCenter
               color: UbuntuColors.green
               id: addEvent
               text: i18n.tr("+")
               visible: (settings.myEvent == 0) ? true : false
               onClicked: {
                   pageStack.push(Qt.resolvedUrl("Settings.qml"))
               }
            }

            Image {
	              id: daysImage
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Image.AlignHCenter
                source: (settings.myEvent == 0) ? Qt.resolvedUrl("../assets/daysg.svg") : Qt.resolvedUrl("../assets/days.svg")
                width: units.gu(20)
                height: units.gu(20)
            }

            DefaultLabel {
                property int longness: quoteList.theList.length - 1
                property int quoteNum: Math.floor(Math.random() * longness)
		            property string theQuote: quoteList.theList[quoteNum]
                id: quote
                visible: (settings.myEvent == 0) ? false : true
                anchors.horizontalCenter: parent.horizontalCenter
                text: theQuote
                Timer {
                    interval: 5000; running: true; repeat: true
                    onTriggered: {
                        quote.quoteNum = Math.floor(Math.random() * quote.longness)
                        // quote.theQuote = quoteList.theList[quote.quoteNum]
                    }
                }
            }

            Item {
                id: quoteList
                property var theList: [
                    "And not only so, but we also boast in our tribulations, knowing that tribulation produces endurance",
                    "Knowing that the proving of your faith works out endurance",
                    "Rejoice in hope; endure in tribulation; persevere in prayer",
                    "The discretion of a man makes him slow to anger",
                    "Better is the end of a thing than its beginning",
                    "Better is patience of spirit than haughtiness of spirit",
                    "Love suffers long. Love is kind; it is not jealous",
                    "With all lowliness and meekness, with long-suffering, bearing one another in love",
                    "And endurance, approvedness; and approvedness, hope",
                    "And let endurance have its perfect work that you may be perfect and entire, lacking in nothing",
                    "And in knowledge, self-control; and in self-control, endurance; and in endurance, godliness",
                    "Do. Or do not. There is no try."
               ]
            }
        }
    }
}
