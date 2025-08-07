/**
 * @name Python Dependency Graph
 * @description Shows modules and the modules they import.
 * @kind graph
 */

import python

from Import i, Importable i2
where i.getImportedModule() = i2
select i.getFile(), i2.getFile(), "imports"
