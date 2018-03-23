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

            // i18n.tr("Metric to display on lock screen")
            Metric {
                property string circleMetric
                id: metric
                name: "nCounter"
                format: circleMetric
                emptyFormat: i18n.tr("Check nCounter")
                domain: "ncounter.joe"
            }

            // i18n.tr("Refers to CalcDays module")
            CalcDays{
                id: updateReport
            }

            // i18n.tr("Displays days counted on Home Page")
            DefaultLabel {
                id: showCounter
                font.pixelSize: 70
                text: (settings.myEvent == 0) ? i18n.tr("Add event to start counting") : i18n.tr("%1 ago").arg(settings.myReport);
                Timer {
                    interval: 1000; running: true; repeat: true
                    onTriggered: {
                        settings.myReport = updateReport.report
                        metric.circleMetric = i18n.tr("%1 ago").arg(updateReport.report)
                        metric.update(0)
                        console.log("nCounter metric updated by timer\n")
                    }
                }
            }

            // i18n.tr("Displays last counter if applicable")
            DefaultLabel {
                id: previous
                visible: (settings.myLast == 0) ? false : true
                text: i18n.tr("Previous ") + settings.myLast
            }

            // i18n.tr("Displays number of restarts if applicable")
            DefaultLabel {
                id: falseStart
                visible: (settings.restarts == 0) ? false : true
                text: i18n.tr("Restarts: ") + settings.restarts
            }

            // i18n.tr("Displays an 'add' button if no event set")
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

            // i18n.tr("Displays grey or yellow graphic depending on event setting")
            Image {
	              id: daysImage
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Image.AlignHCenter
                source: (settings.myEvent == 0) ? Qt.resolvedUrl("../assets/daysg.svg") : Qt.resolvedUrl("../assets/days.svg")
                width: units.gu(20)
                height: units.gu(20)
            }

            // i18n.tr("Displays random quote from quote list")
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

            // i18n.tr("List of quotes. Last quote does not get used for some reason.")
            Item {
                id: quoteList
                property var theList: [
                    i18n.tr("And not only so, but we also boast in our tribulations, knowing that tribulation produces endurance"),
                    i18n.tr("Knowing that the proving of your faith works out endurance"),
                    i18n.tr("Rejoice in hope; endure in tribulation; persevere in prayer"),
                    i18n.tr("The discretion of a man makes him slow to anger"),
                    i18n.tr("Better is the end of a thing than its beginning"),
                    i18n.tr("Better is patience of spirit than haughtiness of spirit"),
                    i18n.tr("Love suffers long. Love is kind; it is not jealous"),
                    i18n.tr("With all lowliness and meekness, with long-suffering, bearing one another in love"),
                    i18n.tr("And endurance, approvedness; and approvedness, hope"),
                    i18n.tr("And let endurance have its perfect work that you may be perfect and entire, lacking in nothing"),
                    i18n.tr("And in knowledge, self-control; and in self-control, endurance; and in endurance, godliness"),
                    i18n.tr("Do. Or do not. There is no try.")
               ]
            }
        }
    }
}
