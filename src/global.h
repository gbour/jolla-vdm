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
#ifndef GLOBAL_H
#define GLOBAL_H

#include <QObject>

class Global: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString locale READ locale)
    Q_PROPERTY(QString apikey READ apikey)
    Q_PROPERTY(QString uri READ uri)

public:
    static Global *instance();

    Global(QObject *parent = 0);
    //~Global();

    QString locale() const {
        return m_locale;
    }

    QString apikey() const {
        return m_apikey;
    }

    QString uri() const {
        return m_uri;
    }

private:
    static QScopedPointer<Global> m_instance;

    QString m_locale;
    QString m_apikey;
    QString m_uri;
};

#endif // GLOBAL_H
