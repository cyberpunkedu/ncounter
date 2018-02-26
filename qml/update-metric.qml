// update-metric.qml
//
// This file is part of the nCounter application. But it is not yet implemented.
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

import QtQml 2.2
import QtQuick 2.4
import UserMetrics 0.1

CalcDays {
    id: autoUpdate
}        

Metric {
    property string circleMetric
    id: metric
    name: "nCounter"
    format: circleMetric
    emptyFormat: i18n.tr("Check nCounter")
    domain: "ncounter.joe"
}

QtObject {
    Component.onCompleted: {
        metric.circleMetric = autoUpdate.report
        metric.update(0)
        console.log("nCounter metric updated automatically\n")
        Qt.quit()
    }
}

            
