#ifndef GLOBAL_H
#define GLOBAL_H

#include <QObject>

class Global: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString apikey READ apikey)
    Q_PROPERTY(QString uri READ uri)

public:
    static Global *instance();

    Global(QObject *parent = 0);
    //~Global();

    QString apikey() const {
        return m_apikey;
    }

    QString uri() const {
        return m_uri;
    }

private:
    static QScopedPointer<Global> m_instance;

    QString m_apikey;
    QString m_uri;
};

#endif // GLOBAL_H
