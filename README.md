# unused-module-finder


[![CircleCI](https://circleci.com/gh/yourgithubhandle/unused-module-finder/tree/master.svg?style=svg)](https://circleci.com/gh/yourgithubhandle/unused-module-finder/tree/master)


**Contains the following libraries and executables:**

```
unused-module-finder@0.0.0
│
├─test/
│   name:    TestUnusedModuleFinder.exe
│   require: unused-module-finder/library
│
├─library/
│   library name: unused-module-finder/library
│   require:
│
└─executable/
    name:    UnusedModuleFinderApp.exe
    require: unused-module-finder/library
```

## Developing:

```
npm install -g esy
git clone <this-repo>
esy install
esy build
```

## Running Binary:

After building the project, you can run the main binary that is produced.

```
esy x UnusedModuleFinderApp.exe 
```

## Running Tests:

```
# Runs the "test" command in `package.json`.
esy test
```
