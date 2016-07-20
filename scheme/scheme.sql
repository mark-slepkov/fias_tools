-- 1
CREATE TABLE IF NOT EXISTS address_objects (
  id         SERIAL PRIMARY KEY,
  aoid       VARCHAR,
  placecode  VARCHAR,
  postalcode VARCHAR,
  extrcode   VARCHAR,
  aoguid     VARCHAR,
  sextcode   VARCHAR,
  terrifnsfl VARCHAR,
  previd     VARCHAR,
  ctarcode   VARCHAR,
  plaincode  VARCHAR,
  oktmo      VARCHAR,
  shortname  VARCHAR,
  formalname VARCHAR,
  currstatus INT,
  nextid     VARCHAR,
  enddate    VARCHAR,
  streetcode VARCHAR,
  ifnsul     VARCHAR,
  regioncode VARCHAR,
  centstatus INT,
  updatedate VARCHAR,
  autocode   VARCHAR,
  startdate  VARCHAR,
  aolevel    INT,
  operstatus INT,
  citycode   VARCHAR,
  normdoc    VARCHAR,
  actstatus  INT,
  ifnsfl     VARCHAR,
  livestatus VARCHAR,
  areacode   VARCHAR,
  parentguid VARCHAR,
  code       VARCHAR,
  offname    VARCHAR,
  okato      VARCHAR,
  terrifnsul VARCHAR,
  cadnum     VARCHAR,
  divtype    INT NOT NULL
);

COMMENT ON TABLE address_objects IS 'Классификатор адресообразующих элементов ';
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
COMMENT ON COLUMN address_objects.okato      IS 'OKATO';
COMMENT ON COLUMN address_objects.oktmo      IS 'OKTMO';
COMMENT ON COLUMN address_objects.updatedate IS 'Дата  внесения записи';
COMMENT ON COLUMN address_objects.shortname  IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN address_objects.aolevel    IS 'Уровень адресного объекта';
COMMENT ON COLUMN address_objects.parentguid IS 'Идентификатор объекта родительского объекта';
COMMENT ON COLUMN address_objects.aoid       IS 'Уникальный идентификатор записи. Ключевое поле.';
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

-- 2
CREATE TABLE IF NOT EXISTS address_object_types (
  id       SERIAL PRIMARY KEY,
  scname   VARCHAR,
  level    INT,
  socrname VARCHAR,
  kod_t_st VARCHAR
);
COMMENT ON TABLE  address_object_types          IS 'Состав и структура файла с информацией по типам адресных объектов в БД ФИАС';
COMMENT ON COLUMN address_object_types.level    IS 'Уровень адресного объекта';
COMMENT ON COLUMN address_object_types.scname   IS 'Краткое наименование типа объекта';
COMMENT ON COLUMN address_object_types.socrname IS 'Полное наименование типа объекта';
COMMENT ON COLUMN address_object_types.kod_t_st IS 'Ключевое поле';

-- 3
CREATE TABLE IF NOT EXISTS center_statuses (
  id         SERIAL PRIMARY KEY,
  centerstid VARCHAR,
  name       VARCHAR
);
COMMENT ON TABLE center_statuses             IS 'Статус центра';
COMMENT ON COLUMN center_statuses.centerstid IS 'Идентификатор статуса';
COMMENT ON COLUMN center_statuses.name       IS 'Наименование';

-- 4
CREATE TABLE IF NOT EXISTS actual_statuses (
  id        SERIAL PRIMARY KEY,
  actstatid INT,
  name      VARCHAR
);
COMMENT ON TABLE actual_statuses            IS 'Статус актуальности ФИАС';
COMMENT ON COLUMN actual_statuses.actstatid IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN actual_statuses.name      IS 'Наименование
                                                0 – Не актуальный
                                                1 – Актуальный (последняя запись по адресному объекту)';
-- 5
CREATE TABLE IF NOT EXISTS current_statuses (
  id         SERIAL PRIMARY KEY,
  curentstid VARCHAR,
  name       VARCHAR
);
COMMENT ON TABLE current_statuses             IS 'Статус актуальности КЛАДР 4.0';
COMMENT ON COLUMN current_statuses.curentstid IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN current_statuses.name       IS 'Наименование
                                                  0 - актуальный,
                                                  1-50, 2-98 – исторический (кроме 51),
                                                  51 - переподчиненный,
                                                  99 - несуществующий';
-- 6
CREATE TABLE IF NOT EXISTS estate_statuses (
  id        SERIAL PRIMARY KEY,
  eststatid INT,
  name      VARCHAR,
  shortname VARCHAR
);
COMMENT ON TABLE estate_statuses            IS 'Признак владения';
COMMENT ON COLUMN estate_statuses.eststatid IS 'Признак владения';
COMMENT ON COLUMN estate_statuses.name      IS 'Наименование';
COMMENT ON COLUMN estate_statuses.shortname IS 'Краткое наименование';
-- 7
CREATE TABLE IF NOT EXISTS house(
  id         SERIAL PRIMARY KEY,
  houseguid  VARCHAR,
  eststatus  INT,
  oktmo      VARCHAR,
  statstatus INT,
  ifnsul     VARCHAR,
  okato      VARCHAR,
  postalcode VARCHAR,
  regioncode VARCHAR,
  housenum   VARCHAR,
  ifnsfl     VARCHAR,
  updatedate VARCHAR,
  terrifnsul VARCHAR,
  counter    INT,
  buildnum   VARCHAR,
  strucnum   VARCHAR,
  terrifnsfl VARCHAR,
  houseid    VARCHAR,
  enddate    VARCHAR,
  strstatus  INT,
  startdate  VARCHAR,
  aoguid     VARCHAR,
  normdoc    VARCHAR,
  -- последних двух полей нет ни у одного объекта из базы
  cadnum     VARCHAR,
  dvitype    VARCHAR
);
COMMENT ON TABLE house IS 'Сведения по номерам домов улиц городов и населенных пунктов';
COMMENT ON COLUMN house.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN house.regioncode IS 'Код региона';
COMMENT ON COLUMN house.ifnsfl     IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN house.terrifnsfl IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN house.ifnsul     IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN house.terrifnsul IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN house.okato      IS 'ОКАТО';
COMMENT ON COLUMN house.oktmo      IS 'ОКТМО';
COMMENT ON COLUMN house.updatedate IS 'Дата время внесения записи';
COMMENT ON COLUMN house.housenum   IS 'Номер дома';
COMMENT ON COLUMN house.eststatus  IS 'Признак владения';
COMMENT ON COLUMN house.buildnum   IS 'Номер корпуса';
COMMENT ON COLUMN house.strucnum   IS 'Номер строения';
COMMENT ON COLUMN house.strstatus  IS 'Признак строения';
COMMENT ON COLUMN house.houseid    IS 'Уникальный идентификатор записи дома';
COMMENT ON COLUMN house.houseguid  IS 'Глобальный уникальный идентификатор дома';
COMMENT ON COLUMN house.aoguid     IS 'Guid записи родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN house.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN house.statstatus IS 'Состояние дома';
COMMENT ON COLUMN house.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN house.counter    IS 'Счетчик записей домов для КЛАДР 4';
COMMENT ON COLUMN house.cadnum     IS 'Кадастровый номер';
COMMENT ON COLUMN house.dvitype    IS 'Тип адресации:
                                       0 - не определено
                                       1 - муниципальный;
                                       2 - административно-территориальный';

-- 8
CREATE TABLE IF NOT EXISTS house_intervals(
  id         SERIAL PRIMARY KEY,
  intguid    VARCHAR,
  oktmo      VARCHAR,
  ifnsul     VARCHAR,
  okato      VARCHAR,
  intstart   INT,
  intend     INT,
  postalcode VARCHAR,
  enddate    VARCHAR,
  ifnsfl     VARCHAR,
  updatedate VARCHAR,
  terrifnsul VARCHAR,
  houseintid VARCHAR,
  terrifnsfl VARCHAR,
  intstatus  INT,
  counter    INT,
  startdate  VARCHAR,
  aoguid     VARCHAR,
  normdoc    VARCHAR
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
COMMENT ON COLUMN house_intervals.houseintid IS 'Идентификатор записи интервала домов';
COMMENT ON COLUMN house_intervals.intguid    IS 'Глобальный уникальный идентификатор интервала домов';
COMMENT ON COLUMN house_intervals.aoguid     IS 'Идентификатор объекта родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN house_intervals.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN house_intervals.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN house_intervals.intstatus  IS 'Статус интервала (обычный, четный, нечетный)';
COMMENT ON COLUMN house_intervals.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN house_intervals.counter    IS 'Счетчик записей домов для КЛАДР 4';
-- 9
CREATE TABLE IF NOT EXISTS house_state_statuses(
  id        SERIAL PRIMARY KEY,
  housestid INT,
  name      VARCHAR
);
COMMENT ON TABLE  house_state_statuses IS 'Статус состояния домов';
COMMENT ON COLUMN house_state_statuses.housestid IS 'Идентификатор статуса';
COMMENT ON COLUMN house_state_statuses.name      IS 'Наименование';

-- 10
CREATE TABLE IF NOT EXISTS interval_statuses(
  id         SERIAL PRIMARY KEY,
  intvstatid INT,
  name       VARCHAR

);
COMMENT ON TABLE  interval_statuses            IS 'Статус интервала домов';
COMMENT ON COLUMN interval_statuses.intvstatid IS 'Идентификатор статуса (обычный, четный, нечетный)';
COMMENT ON COLUMN interval_statuses.name       IS 'Наименование';

-- 11
CREATE TABLE IF NOT EXISTS landmark(
  id         SERIAL PRIMARY KEY,
  location   VARCHAR,
  -- Этоих столбцов нет ни у одного объекта из XML
  regioncode VARCHAR,
  cadnum     VARCHAR,
  -----------------------------------------------
  okato      VARCHAR,
  oktmo      VARCHAR,
  enddate    VARCHAR,
  ifnsfl     VARCHAR,
  updatedate VARCHAR,
  postalcode VARCHAR,
  terrifnsul VARCHAR,
  ifnsul     VARCHAR,
  terrifnsfl VARCHAR,
  landguid   VARCHAR,
  startdate  VARCHAR,
  aoguid     VARCHAR,
  landid     VARCHAR,
  normdoc    VARCHAR
);
COMMENT ON TABLE landmark IS 'Описание мест расположения имущественных объектов';
COMMENT ON COLUMN landmark.location     IS 'Месторасположение ориентира';
COMMENT ON COLUMN landmark.regioncode   IS 'Месторасположение ориентира';
COMMENT ON COLUMN landmark.postalcode   IS 'Почтовый индекс';
COMMENT ON COLUMN landmark.ifnsfl       IS 'Код ИФНС ФЛ';
COMMENT ON COLUMN landmark.terrifnsfl   IS 'Код территориального участка ИФНС ФЛ';
COMMENT ON COLUMN landmark.ifnsul       IS 'Код ИФНС ЮЛ';
COMMENT ON COLUMN landmark.terrifnsul   IS 'Код территориального участка ИФНС ЮЛ';
COMMENT ON COLUMN landmark.okato        IS 'ОКАТО';
COMMENT ON COLUMN landmark.oktmo        IS 'ОКТМО';
COMMENT ON COLUMN landmark.updatedate   IS 'Дата внесения записи';
COMMENT ON COLUMN landmark.landid       IS 'Уникальный идентификатор записи ориентира';
COMMENT ON COLUMN landmark.landguid     IS 'Глобальный уникальный идентификатор ориентира';
COMMENT ON COLUMN landmark.aoguid       IS 'Уникальный идентификатор родительского объекта (улицы, города, населенного пункта и т.п.)';
COMMENT ON COLUMN landmark.startdate    IS 'Начало действия записи';
COMMENT ON COLUMN landmark.enddate      IS 'Окончание действия записи';
COMMENT ON COLUMN landmark.normdoc      IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN landmark.cadnum       IS 'Кадастровый номер';
-- 12
CREATE TABLE IF NOT EXISTS normative_document(
  id        SERIAL PRIMARY KEY,
  docdate   VARCHAR,
  normdocid VARCHAR,
  docnum    VARCHAR,
  doctype   INT,
  docname   VARCHAR,
  -- Поле не встречается ни у одного объекта
  docimgid  INT
);
COMMENT ON TABLE normative_document IS 'Сведения по нормативному документу, являющемуся основанием присвоения адресному элементу наименования';
COMMENT ON COLUMN normative_document.normdocid IS 'Идентификатор нормативного документа';
COMMENT ON COLUMN normative_document.docname   IS 'Наименование документа';
COMMENT ON COLUMN normative_document.docdate   IS 'Дата документа';
COMMENT ON COLUMN normative_document.docnum    IS 'Номер документа';
COMMENT ON COLUMN normative_document.doctype   IS 'Тип документа';
COMMENT ON COLUMN normative_document.docimgid  IS 'Идентификатор образа (внешний ключ)';
-- 13
CREATE TABLE IF NOT EXISTS normative_document_type(
  id       SERIAL PRIMARY KEY,
  ndtypeid INT,
  name     VARCHAR
);
COMMENT ON TABLE normative_document_type IS 'Тип нормативного документа';
COMMENT ON COLUMN normative_document_type.ndtypeid IS 'Идентификатор записи (ключ)';
COMMENT ON COLUMN normative_document_type.name     IS 'Наименование типа нормативного документа';

-- 14
CREATE TABLE IF NOT EXISTS operation_status(
  id         SERIAL PRIMARY KEY,
  operstatid INT,
  name       VARCHAR
);
COMMENT ON TABLE operation_status IS 'Статус действия';
COMMENT ON COLUMN operation_status.operstatid IS 'Идентификатор статуса (ключ)';
COMMENT ON COLUMN operation_status.name       IS 'Наименование';

-- 15
CREATE TABLE IF NOT EXISTS room(
  id         SERIAL PRIMARY KEY,
  houseguid  VARCHAR,
  regioncode VARCHAR,
  cadnum     VARCHAR,
  roomguid   VARCHAR,
  operstatus INT,
  roomtype   VARCHAR,
  postalcode VARCHAR,
  flatnumber VARCHAR,
  updatedate VARCHAR,
  roomcadnum VARCHAR,
  nextid     VARCHAR,
  livestatus VARCHAR,
  previd     VARCHAR,
  roomnumber VARCHAR,
  enddate    VARCHAR,
  startdate  VARCHAR,
  roomid     VARCHAR,
  normdoc    VARCHAR,
  flattype   VARCHAR
);
COMMENT ON TABLE room IS 'Классификатор помещений';
COMMENT ON COLUMN room.roomid     IS 'Уникальный идентификатор записи. Ключевое поле.';
COMMENT ON COLUMN room.roomguid   IS 'Глобальный уникальный идентификатор адресного объекта (помещения)';
COMMENT ON COLUMN room.flatnumber IS 'Номер помещения или офиса';
COMMENT ON COLUMN room.flattype   IS 'Тип помещения';
COMMENT ON COLUMN room.roomnumber IS 'Номер комнаты';
COMMENT ON COLUMN room.roomtype   IS 'Тип комнаты';
COMMENT ON COLUMN room.regioncode IS 'Код региона';
COMMENT ON COLUMN room.postalcode IS 'Почтовый индекс';
COMMENT ON COLUMN room.houseguid  IS 'Дата внесения записи';
COMMENT ON COLUMN room.houseguid  IS 'Дата внесения записи';
COMMENT ON COLUMN room.previd     IS 'Идентификатор записи связывания с предыдущей исторической записью';
COMMENT ON COLUMN room.nextid     IS 'Идентификатор записи связывания с последующей исторической записью';
COMMENT ON COLUMN room.startdate  IS 'Начало действия записи';
COMMENT ON COLUMN room.enddate    IS 'Окончание действия записи';
COMMENT ON COLUMN room.livestatus IS 'Признак действующего адресного объекта';
COMMENT ON COLUMN room.normdoc    IS 'Внешний ключ на нормативный документ';
COMMENT ON COLUMN room.operstatus IS 'Статус действия над записью – причина появления записи (см. описание таблицы operation_status)';
COMMENT ON COLUMN room.cadnum     IS 'Кадастровый номер помещения';
COMMENT ON COLUMN room.roomcadnum IS 'Кадастровый номер комнаты в помещении';
-- 16
CREATE TABLE IF NOT EXISTS stead(
  id         SERIAL PRIMARY KEY,
  regioncode VARCHAR,
  oktmo      VARCHAR,
  ifnsul     VARCHAR,
  updatedate VARCHAR,
  ifnsfl     VARCHAR,
  number     VARCHAR,
  nextid     VARCHAR,
  livestatus VARCHAR,
  divtype    VARCHAR,
  parentguid VARCHAR,
  terrifnsfl VARCHAR,
  steadid    VARCHAR,
  enddate    VARCHAR,
  cadnum     VARCHAR,
  normdoc    VARCHAR,
  okato      VARCHAR,
  operstatus INT,
  postalcode VARCHAR,
  terrifnsul VARCHAR,
  steadguid  VARCHAR,
  previd     VARCHAR,
  startdate  VARCHAR
);
COMMENT ON TABLE stead IS 'Классификатор земельных участков';
COMMENT ON COLUMN stead.steadid    IS 'Уникальный идентификатор записи. Ключевое поле.';
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

-- 17
CREATE TABLE IF NOT EXISTS structure_status(
  id        SERIAL PRIMARY KEY,
  shortname VARCHAR,
  strstatid INT,
  name      VARCHAR
);
COMMENT ON TABLE structure_status IS 'Признак строения';
COMMENT ON COLUMN structure_status.strstatid IS 'Признак строения';
COMMENT ON COLUMN structure_status.name      IS 'Наименование';
COMMENT ON COLUMN structure_status.shortname IS 'Краткое наименование';
