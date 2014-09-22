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
