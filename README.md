# zip-odin

[![](https://img.shields.io/github/v/tag/thechampagne/zip-odin?label=version)](https://github.com/thechampagne/zip-odin/releases/latest) [![](https://img.shields.io/github/license/thechampagne/zip-odin)](https://github.com/thechampagne/zip-odin/blob/main/LICENSE)

Odin binding for a portable, simple **zip** library.

### Example
```odin
package main

import "zip"

main :: proc() {
    zip_file := zip.open("odin.zip", 6, 'w')
    defer zip.close(zip_file)

    zip.entry_open(zip_file, "test")
    defer zip.entry_close(zip_file)

    content := "test content"
    zip.entry_write(zip_file, &content, len(content))
}
```

### References
 - [zip](https://github.com/kuba--/zip)

### License

This repo is released under the [MIT License](https://github.com/thechampagne/zip-odin/blob/main/LICENSE).
