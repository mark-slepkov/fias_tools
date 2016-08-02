
-- 1
CREATE TABLE IF NOT EXISTS actual_statuses (
  id        INT PRIMARY KEY,
  name      VARCHAR
);
COMMENT ON TABLE actual_statuses            IS 'Статус актуальности ФИАС';
COMMENT ON COLUMN actual_statuses.id        IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN actual_statuses.name      IS 'Наименование
                                                0 – Не актуальный
                                                1 – Актуальный (последняя запись по адресному объекту)';

-- 2
CREATE TABLE IF NOT EXISTS center_statuses (
  id         INT PRIMARY KEY,
  name       VARCHAR
);
COMMENT ON TABLE center_statuses             IS 'Статус центра';
COMMENT ON COLUMN center_statuses.id         IS 'Идентификатор статуса';
COMMENT ON COLUMN center_statuses.name       IS 'Наименование';

-- 3
CREATE TABLE IF NOT EXISTS current_statuses (
  id         INT PRIMARY KEY,
  name       VARCHAR
);
COMMENT ON TABLE current_statuses             IS 'Статус актуальности КЛАДР 4.0';
COMMENT ON COLUMN current_statuses.id         IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN current_statuses.name       IS 'Наименование
                                                  0 - актуальный,
                                                  1-50, 2-98 – исторический (кроме 51),
                                                  51 - переподчиненный,
                                                  99 - несуществующий';

-- 4
CREATE TABLE IF NOT EXISTS operation_statuses(
  id         INT PRIMARY KEY,
  name       VARCHAR
);
COMMENT ON TABLE operation_statuses IS 'Статус действия';
COMMENT ON COLUMN operation_statuses.id   IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN operation_statuses.name IS 'Наименование';


-- 10
CREATE TABLE IF NOT EXISTS address_object_types (
  id       VARCHAR PRIMARY KEY,
  scname   VARCHAR,
  level    INT,
  socrname VARCHAR

);
COMMENT ON TABLE  address_object_types IS 'Состав и структура файла с информацией по типам адресных объектов в БД ФИАС';
COMMENT ON COLUMN address_object_types.id       IS 'Ключевое поле';
COMMENT ON COLUMN address_object_types.level    IS 'Уровень адресного объекта';
COMMENT ON COLUMN address_object_types.scname   IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN address_object_types.socrname IS 'Полное наименование типа объекта';


-- 7
CREATE TABLE IF NOT EXISTS normative_document_types(
  id       INT PRIMARY KEY,
  name     VARCHAR
);
COMMENT ON TABLE normative_document_types IS 'Тип нормативного документа';
COMMENT ON COLUMN normative_document_types.id   IS 'Идентификатор записи (ключ)';
COMMENT ON COLUMN normative_document_types.name IS 'Наименование типа нормативного документа';

-- 11
CREATE TABLE IF NOT EXISTS normative_documents(
  id        VARCHAR PRIMARY KEY,
  docdate   DATE,
  docnum    VARCHAR,
  doctype   INT REFERENCES normative_document_types,
  docname   VARCHAR,
  -- Поле не встречается ни у одного объекта
  docimgid  INT
);
COMMENT ON TABLE normative_documents IS 'Сведения по нормативному документу, являющемуся основанием присвоения адресному элементу наименования';
COMMENT ON COLUMN normative_documents.id        IS 'Идентификатор нормативного документа';
COMMENT ON COLUMN normative_documents.docname   IS 'Наименование документа';
COMMENT ON COLUMN normative_documents.docdate   IS 'Дата документа';
COMMENT ON COLUMN normative_documents.docnum    IS 'Номер документа';
COMMENT ON COLUMN normative_documents.doctype   IS 'Тип документа';
COMMENT ON COLUMN normative_documents.docimgid  IS 'Идентификатор образа (внешний ключ)';

-- 0
CREATE TABLE IF NOT EXISTS address_objects (
  id         VARCHAR PRIMARY KEY,
  aoguid     VARCHAR,
  parentguid VARCHAR,
  placecode  VARCHAR,
  postalcode VARCHAR,
  extrcode   VARCHAR,
  sextcode   VARCHAR,
  terrifnsfl VARCHAR,
  previd     VARCHAR,
  ctarcode   VARCHAR,
  plaincode  VARCHAR,
  oktmo      VARCHAR,
  shortname  VARCHAR,
  formalname VARCHAR,
  currstatus INT REFERENCES current_statuses,
  nextid     VARCHAR,
  updatedate DATE,
  startdate  DATE,
  enddate    DATE,
  streetcode VARCHAR,
  ifnsul     VARCHAR,
  regioncode VARCHAR,
  centstatus INT REFERENCES center_statuses,
  autocode   VARCHAR,
  aolevel    INT,
  operstatus INT REFERENCES operation_statuses,
  citycode   VARCHAR,
  normdoc    VARCHAR,  -- REFERENCES normative_documents
  actstatus  INT REFERENCES actual_statuses,
  ifnsfl     VARCHAR,
  livestatus VARCHAR,
  areacode   VARCHAR,
  code       VARCHAR,
  offname    VARCHAR,
  okato      VARCHAR,
  terrifnsul VARCHAR,
  cadnum     VARCHAR,
  divtype    INT
);

COMMENT ON TABLE address_objects IS 'Классификатор адресообразующих элементов ';
COMMENT ON COLUMN address_objects.id         IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN address_objects.aoguid     IS 'Глобальный уникальный идентификатор адресного объекта';
COMMENT ON COLUMN address_objects.formalname IS 'Формализованное наименование';
COMMENT ON COLUMN address_objects.regioncode IS 'Код региона';
COMMENT ON COLUMN address_objects.autocode   IS 'Код автономии';
COMMENT ON COLUMN address_objects.areacode   IS 'Код района';
COMMENT ON COLUMN address_objects.citycode   IS 'Код города';
COMMENT ON COLUMN address_objects.ctarcode   IS 'Код внутригородского района';
COMMENT ON COLUMN address_objects.placecode  IS 'Код населенного пункта';
COMMENT ON COLUMN address_objects.streetcode IS 'Код улицы';
COMMENT ON COLUMN address_objects.extrcode   IS 'Код дополнительного адресообразующего элемента';
COMMENT ON COLUMN address_objects.sextcode   IS 'Код подчиненного дополнительного адресообразующего элемента';
COMMENT ON COLUMN address_objects.offname    IS 'Официальное наименование';
COMMENT ON COLUMN address_objects.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN address_objects.ifnsfl     IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN address_objects.terrifnsfl IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN address_objects.ifnsul     IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN address_objects.terrifnsul IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN address_objects.okato      IS 'ОКАТО';
COMMENT ON COLUMN address_objects.oktmo      IS 'ОКТМО';
COMMENT ON COLUMN address_objects.updatedate IS 'Дата внесения записи';
COMMENT ON COLUMN address_objects.shortname  IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN address_objects.aolevel    IS 'Уровень адресного объекта';
COMMENT ON COLUMN address_objects.parentguid IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN address_objects.previd     IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN address_objects.nextid     IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN address_objects.code       IS 'Код адресного объекта одной строкой с признаком актуальности из КЛАДР 4.0. ';
COMMENT ON COLUMN address_objects.plaincode  IS 'Код адресного объекта из КЛАДР 4.0 одной строкой без признака актуальности (последних двух цифр)';
COMMENT ON COLUMN address_objects.actstatus  IS 'Статус исторической записи в жизненном цикле адресного объекта:
                                                 0 – не последняя
                                                 1 - последняя';
COMMENT ON COLUMN address_objects.centstatus IS 'Статус центра';
COMMENT ON COLUMN address_objects.operstatus IS 'Статус действия над записью – причина появления записи (см. описание таблицы OperationStatus):
                                                 01 – Инициация;
                                                 10 – Добавление;
                                                 20 – Изменение;
                                                 21 – Групповое изменение;
                                                 30 – Удаление;
                                                 31 - Удаление вследствие удаления вышестоящего объекта;
                                                 40 – Присоединение адресного объекта (слияние);
                                                 41 – Переподчинение вследствие слияния вышестоящего объекта;
                                                 42 - Прекращение существования вследствие присоединения к другому адресному объекту;
                                                 43 - Создание нового адресного объекта в результате слияния адресных объектов;
                                                 50 – Переподчинение;
                                                 51 – Переподчинение вследствие переподчинения вышестоящего объекта;
                                                 60 – Прекращение существования вследствие дробления;
                                                 61 – Создание нового адресного объекта в результате дробления';
COMMENT ON COLUMN address_objects.currstatus IS 'Статус актуальности КЛАДР 4 (последние две цифры в коде)';
COMMENT ON COLUMN address_objects.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN address_objects.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN address_objects.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN address_objects.livestatus IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN address_objects.cadnum     IS 'Кадастровый номер';
COMMENT ON COLUMN address_objects.divtype    IS 'Тип адресации:
                                                 0 - не определено
                                                 1 - муниципальный;
                                                 2 - административно-территориальный';
CREATE INDEX index_address_objects_aoguid ON address_objects (aoguid);
CREATE INDEX index_address_objects_parentguid ON address_objects (parentguid);
CREATE INDEX index_address_objects_actstatus ON address_objects (actstatus);

-- 5
CREATE TABLE IF NOT EXISTS house_state_statuses(
  id        INT PRIMARY KEY,
  name      VARCHAR
);
COMMENT ON TABLE  house_state_statuses IS 'Статус состояния домов';
COMMENT ON COLUMN house_state_statuses.id IS 'Идентификатор статуса';
COMMENT ON COLUMN house_state_statuses.name      IS 'Наименование';

-- 8
CREATE TABLE IF NOT EXISTS structure_statuses(
  id        INT PRIMARY KEY,
  shortname VARCHAR,
  name      VARCHAR
);
COMMENT ON TABLE structure_statuses IS 'Признак строения';
COMMENT ON COLUMN structure_statuses.id IS 'Признак строения';
COMMENT ON COLUMN structure_statuses.name      IS 'Наименование';
COMMENT ON COLUMN structure_statuses.shortname IS 'Краткое наименование';

-- 9
CREATE TABLE IF NOT EXISTS estate_statuses (
  id        INT PRIMARY KEY,
  name      VARCHAR,
  shortname VARCHAR
);
COMMENT ON TABLE estate_statuses IS 'Признак владения';
COMMENT ON COLUMN estate_statuses.id IS 'Признак владения';
COMMENT ON COLUMN estate_statuses.name      IS 'Наименование';
COMMENT ON COLUMN estate_statuses.shortname IS 'Краткое наименование';


-- 0
CREATE TABLE IF NOT EXISTS houses(
  id          VARCHAR PRIMARY KEY,
  houseguid   VARCHAR,
  eststatus   INT REFERENCES estate_statuses,
  oktmo       VARCHAR,
  statestatus INT REFERENCES house_state_statuses,
  ifnsul      VARCHAR,
  okato       VARCHAR,
  postalcode  VARCHAR,
  regioncode  VARCHAR,
  housenum    VARCHAR,
  ifnsfl      VARCHAR,
  updatedate  DATE,
  terrifnsul  VARCHAR,
  counter     INT,
  buildnum    VARCHAR,
  strucnum    VARCHAR,
  terrifnsfl  VARCHAR,
  startdate   DATE,
  enddate     DATE,
  strstatus   INT REFERENCES structure_statuses,
  aoguid      VARCHAR,
  normdoc     VARCHAR, -- REFERENCES normative_documents,
  -- последних двух полей нет ни у одного объекта из базы
  cadnum     VARCHAR,
  divtype    VARCHAR
);
COMMENT ON TABLE houses IS 'Сведения по номерам домов улиц городов и населенных пунктов';
COMMENT ON COLUMN houses.postalcode  IS 'Почтовый индекс';
COMMENT ON COLUMN houses.regioncode  IS 'Код региона';
COMMENT ON COLUMN houses.ifnsfl      IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN houses.terrifnsfl  IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN houses.ifnsul      IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN houses.terrifnsul  IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN houses.okato       IS 'ОКАТО';
COMMENT ON COLUMN houses.oktmo       IS 'ОКТМО';
COMMENT ON COLUMN houses.updatedate  IS 'Дата время внесения записи';
COMMENT ON COLUMN houses.housenum    IS 'Номер дома';
COMMENT ON COLUMN houses.eststatus   IS 'Признак владения';
COMMENT ON COLUMN houses.buildnum    IS 'Номер корпуса';
COMMENT ON COLUMN houses.strucnum    IS 'Номер строения';
COMMENT ON COLUMN houses.strstatus   IS 'Признак строения';
COMMENT ON COLUMN houses.id          IS 'Уникальный идентификатор записи дома';
COMMENT ON COLUMN houses.houseguid   IS 'Глобальный уникальный идентификатор дома';
COMMENT ON COLUMN houses.aoguid      IS 'Guid записи родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN houses.startdate   IS 'Начало действия записи';
COMMENT ON COLUMN houses.statestatus IS 'Состояние дома';
COMMENT ON COLUMN houses.normdoc     IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN houses.counter     IS 'Счетчик записей домов для КЛАДР 4';
COMMENT ON COLUMN houses.cadnum      IS 'Кадастровый номер';
COMMENT ON COLUMN houses.divtype     IS 'Тип адресации:
                                        0 - не определено
                                        1 - муниципальный;
                                        2 - административно-территориальный';

-- 6
CREATE TABLE IF NOT EXISTS interval_statuses(
  id         INT PRIMARY KEY,
  name       VARCHAR

);
COMMENT ON TABLE  interval_statuses      IS 'Статус интервала домов';
COMMENT ON COLUMN interval_statuses.id   IS 'Идентификатор статуса (обычный, четный, нечетный)';
COMMENT ON COLUMN interval_statuses.name IS 'Наименование';

-- 0
CREATE TABLE IF NOT EXISTS house_intervals(
  id         VARCHAR PRIMARY KEY,
  intguid    VARCHAR,
  oktmo      VARCHAR,
  ifnsul     VARCHAR,
  okato      VARCHAR,
  intstart   INT,
  intend     INT,
  postalcode VARCHAR,
  enddate    DATE,
  ifnsfl     VARCHAR,
  updatedate DATE,
  terrifnsul VARCHAR,
  terrifnsfl VARCHAR,
  intstatus  INT REFERENCES interval_statuses,
  counter    INT,
  startdate  DATE,
  aoguid     VARCHAR,
  normdoc    VARCHAR -- REFERENCES normative_documents
);
COMMENT ON TABLE house_intervals IS 'Интервалы домов';
COMMENT ON COLUMN house_intervals.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN house_intervals.ifnsfl     IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN house_intervals.terrifnsfl IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN house_intervals.ifnsul     IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN house_intervals.terrifnsul IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN house_intervals.okato      IS 'ОКАТО';
COMMENT ON COLUMN house_intervals.oktmo      IS 'ОКТМО';
COMMENT ON COLUMN house_intervals.updatedate IS 'Дата внесения записи';
COMMENT ON COLUMN house_intervals.intstart   IS 'Значение начала интервала';
COMMENT ON COLUMN house_intervals.intend     IS 'Значение окончания интервала';
COMMENT ON COLUMN house_intervals.id         IS 'Идентификатор записи интервала домов';
COMMENT ON COLUMN house_intervals.intguid    IS 'Глобальный уникальный идентификатор интервала домов';
COMMENT ON COLUMN house_intervals.aoguid     IS 'Идентификатор объекта родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN house_intervals.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN house_intervals.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN house_intervals.intstatus  IS 'Статус интервала (обычный, четный, нечетный)';
COMMENT ON COLUMN house_intervals.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN house_intervals.counter    IS 'Счетчик записей домов для КЛАДР 4';


-- 0
CREATE TABLE IF NOT EXISTS landmarks(
  id         VARCHAR PRIMARY KEY,
  location   VARCHAR,
  -- Этих столбцов нет ни у одного объекта из XML
  regioncode VARCHAR,
  cadnum     VARCHAR,
  -----------------------------------------------
  okato      VARCHAR,
  oktmo      VARCHAR,
  enddate    DATE,
  ifnsfl     VARCHAR,
  updatedate DATE,
  postalcode VARCHAR,
  terrifnsul VARCHAR,
  ifnsul     VARCHAR,
  terrifnsfl VARCHAR,
  landguid   VARCHAR,
  startdate  DATE,
  aoguid     VARCHAR,
  normdoc    VARCHAR -- REFERENCES normative_documents
);
COMMENT ON TABLE landmarks IS 'Описание мест расположения имущественных объектов';
COMMENT ON COLUMN landmarks.location   IS 'Месторасположение ориентира';
COMMENT ON COLUMN landmarks.regioncode IS 'Месторасположение ориентира';
COMMENT ON COLUMN landmarks.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN landmarks.ifnsfl     IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN landmarks.terrifnsfl IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN landmarks.ifnsul     IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN landmarks.terrifnsul IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN landmarks.okato      IS 'ОКАТО';
COMMENT ON COLUMN landmarks.oktmo      IS 'ОКТМО';
COMMENT ON COLUMN landmarks.updatedate IS 'Дата внесения записи';
COMMENT ON COLUMN landmarks.id         IS 'Уникальный идентификатор записи ориентира';
COMMENT ON COLUMN landmarks.landguid   IS 'Глобальный уникальный идентификатор ориентира';
COMMENT ON COLUMN landmarks.aoguid     IS 'Уникальный идентификатор родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN landmarks.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN landmarks.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN landmarks.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN landmarks.cadnum     IS 'Кадастровый номер';


-- 0
CREATE TABLE IF NOT EXISTS stead(
  id         VARCHAR PRIMARY KEY,
  regioncode VARCHAR,
  oktmo      VARCHAR,
  ifnsul     VARCHAR,
  updatedate DATE,
  ifnsfl     VARCHAR,
  number     VARCHAR,
  nextid     VARCHAR,
  livestatus VARCHAR,
  divtype    VARCHAR,
  parentguid VARCHAR,
  terrifnsfl VARCHAR,
  enddate    DATE,
  cadnum     VARCHAR,
  normdoc    VARCHAR, -- REFERENCES normative_documents,
  okato      VARCHAR,
  operstatus INT REFERENCES operation_statuses,
  postalcode VARCHAR,
  terrifnsul VARCHAR,
  steadguid  VARCHAR,
  previd     VARCHAR,
  startdate  DATE
);
COMMENT ON TABLE stead IS 'Классификатор земельных участков';
COMMENT ON COLUMN stead.id         IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN stead.steadguid  IS 'Глобальный уникальный идентификатор адресного объекта (земельного участка)';
COMMENT ON COLUMN stead.number     IS 'Номер земельного участка';
COMMENT ON COLUMN stead.regioncode IS 'Код региона';
COMMENT ON COLUMN stead.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN stead.ifnsfl     IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN stead.terrifnsfl IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN stead.ifnsul     IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN stead.terrifnsul IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN stead.okato      IS 'ОКАТО';
COMMENT ON COLUMN stead.oktmo      IS 'ОКТМО';
COMMENT ON COLUMN stead.updatedate IS 'Дата внесения записи';
COMMENT ON COLUMN stead.parentguid IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN stead.previd     IS 'Идентификатор записи связывания с предыдушей исторической записью';
COMMENT ON COLUMN stead.nextid     IS 'Идентификатор записи  связывания с последующей исторической записью';
COMMENT ON COLUMN stead.operstatus IS 'Статус действия над записью – причина появления записи (см. описание таблицы operation_status)';
COMMENT ON COLUMN stead.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN stead.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN stead.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN stead.livestatus IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN stead.cadnum     IS 'Кадастровый номер';
COMMENT ON COLUMN stead.divtype    IS 'Тип адресации:
                                       0 - не определено
                                       1 - муниципальный;
                                       2 - административно-территориальный';

-- 0
CREATE TABLE IF NOT EXISTS rooms(
  id         VARCHAR PRIMARY KEY,
  houseguid  VARCHAR,
  regioncode VARCHAR,
  cadnum     VARCHAR,
  roomguid   VARCHAR,
  operstatus INT REFERENCES operation_statuses,
  roomtype   VARCHAR,
  postalcode VARCHAR,
  flatnumber VARCHAR,
  updatedate DATE,
  roomcadnum VARCHAR,
  nextid     VARCHAR,
  livestatus VARCHAR,
  previd     VARCHAR,
  roomnumber VARCHAR,
  enddate    DATE,
  startdate  DATE,
  normdoc    VARCHAR, -- REFERENCES normative_documents,
  flattype   VARCHAR
);
COMMENT ON TABLE rooms IS 'Классификатор помещений';
COMMENT ON COLUMN rooms.id     IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN rooms.roomguid   IS 'Глобальный уникальный идентификатор адресного объекта (помещения)';
COMMENT ON COLUMN rooms.flatnumber IS 'Номер помещения или офиса';
COMMENT ON COLUMN rooms.flattype   IS 'Тип помещения';
COMMENT ON COLUMN rooms.roomnumber IS 'Номер комнаты';
COMMENT ON COLUMN rooms.roomtype   IS 'Тип комнаты';
COMMENT ON COLUMN rooms.regioncode IS 'Код региона';
COMMENT ON COLUMN rooms.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN rooms.houseguid  IS 'Дата внесения записи';
COMMENT ON COLUMN rooms.houseguid  IS 'Дата внесения записи';
COMMENT ON COLUMN rooms.previd     IS 'Идентификатор записи связывания с предыдущей исторической записью';
COMMENT ON COLUMN rooms.nextid     IS 'Идентификатор записи связывания с последующей исторической записью';
COMMENT ON COLUMN rooms.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN rooms.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN rooms.livestatus IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN rooms.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN rooms.operstatus IS 'Статус действия над записью – причина появления записи (см. описание таблицы operation_status)';
COMMENT ON COLUMN rooms.cadnum     IS 'Кадастровый номер помещения';
COMMENT ON COLUMN rooms.roomcadnum IS 'Кадастровый номер комнаты в помещении';