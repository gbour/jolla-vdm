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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QDebug>
#include <QGuiApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QDateTime>
#include <QTranslator>
#include <sailfishapp.h>
#include "global.h"


int main(int argc, char *argv[])
{
    QGuiApplication *app = SailfishApp::application(argc,argv);
    app->setApplicationVersion(APP_VERSION);

    QTranslator translator;
    translator.load("VDM-"+ QLocale::system().name().split("_").first(),
                    SailfishApp::pathTo("translations").path());
    //translator.load("VDM-fr", SailfishApp::pathTo("translations").path());
    app->installTranslator(&translator);

    QQuickView *view = SailfishApp::createView();

    Global *g = Global::instance();
    qDebug() << "global= " << g << "," << g->uri();
    view->rootContext()->setContextProperty("myglobal", g);

    view->setSource(SailfishApp::pathTo("qml/VDM.qml"));
    view->rootContext()->setContextProperty("APP_VERSION", APP_VERSION);
    view->rootContext()->setContextProperty("GIT_VERSION", GIT_VERSION);

    QDateTime buildat = QDateTime::fromMSecsSinceEpoch(qint64(BUILD_DATE)*1000);
    view->rootContext()->setContextProperty("BUILD_DATE" , buildat.toString(Qt::DefaultLocaleShortDate));

    view->show();

    return app->exec();
}

