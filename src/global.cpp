/*
    This file is part of «VDM app».

    «VDM app» is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    «VDM app» is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with «VDM app».  If not, see <http://www.gnu.org/licenses/>.
*/

#include "global.h"
#include <QtCore>

QScopedPointer<Global> Global::m_instance(0);

Global::Global(QObject *parent) :
    QObject(parent)
{
    m_apikey = APIKEY;
    //m_uri    = "http://api.fmylife.com";      // prod
    m_uri    = "http://sandbox.betacie.com";  // sandbox
}

Global *Global::instance() {
    if(m_instance.isNull()) {
        m_instance.reset(new Global);
    }

    return m_instance.data();
}
