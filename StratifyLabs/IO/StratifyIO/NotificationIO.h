/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#ifndef NOTIFICATIONMANAGER_H
#define NOTIFICATIONMANAGER_H

#include "IO.h"
#include "TraceEvent.h"

namespace StratifyIO {


class NotificationIO : IO
{
    Q_OBJECT
public:
    NotificationIO(Link & link);

    void listen();
    void stop(){ mStop = false; }

signals:
    void deviceAccess(const QString & device, bool read, int nbyte);
    void fileAccess(const QString & file, bool read, int nbyte);
    void traceEvent(const TraceEvent & event);

private:
    volatile bool mStop;

};

}

#endif // NOTIFICATIONMANAGER_H