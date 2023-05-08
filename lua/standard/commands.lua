local options = { force = true }

-- https://github.com/nanotee/nvim-lua-guide/blob/master/README.md
-- https://maven.apache.org/guides/mini/guide-creating-archetypes.html

vim.api.nvim_create_user_command(
  'JavaInitProject',
  function(opts)
    local args = vim.split(opts.args, " ")
    local groupId = args[1]
    local artifactId = args[1]
    local MainClassName = 'App'
    if args[2] then
      artifactId = args[2]
    end

    if args[3] then
      MainClassName = args[3]
    end
    local command = 'mvn archetype:generate -DarchetypeArtifactId:org.apache.maven.archetypes:maven-archetype-quickstart:1.4 -DgroupId='
        .. groupId .. ' -DartifactId=' .. artifactId .. ' -DinteractiveMode=false'
    local properties = "\\n\\t<properties>\\n\\t\\t<maven.compiler.source>11<\\/maven.compiler.source>\\n\\t\\t<maven.compiler.target>11<\\/maven.compiler.target>\\n\\t\\t<exec.mainClass>"
        .. groupId .. "." .. MainClassName .. "<\\/exec.mainClass>\\n\\t<\\/properties>"
    -- local buildData = "\\n\\t<build>\\n\\t<plugins>\\n\\t\\t<plugin>\\n\\t\\t\\t<groupId>org.apache.maven.plugins</groupId>\\n\\t\\t\\t<artifactId>maven-jar-plugin</artifactId>\\n\\t\\t\\t<version>3.1.0</version>\\n\\t\\t\\t<configuration>\\n\\t\\t\\t\\t<archive>\\n\\t\\t\\t\\t\\t<manifest>\\n\\t\\t\\t\\t\\t\\t<addClasspath>true</addClasspath>\\n\\t\\t\\t\\t\\t\\t<classpathPrefix>lib/</classpathPrefix>\\n\\t\\t\\t\\t\\t\\t<mainClass>" .. MainClassName .. "</mainClass>\\n\\t\\t\\t\\t\\t</manifest>\\n\\t\\t\\t\\t\\t</archive>\\n\\t\\t\\t\\t</configuration>\\n\\t\\t\\t</plugin>\\n\\t\\t</plugins>\\n\\t</build>"
    local addPropertiesCommand = "sed -i '' 's/\\/url>/\\/url>" .. properties .. "/' ./pom.xml"
    -- local addBuildCommand = "sed -i '' 's/\\/properties>/\\/properties>" .. buildData .. "/' ./pom.xml"
    local renameMainClass = ''
    if MainClassName ~= 'App' then
      renameMainClass = " && cd src/main/java/" ..
          groupId ..
          " && sed -i '' 's/App/" .. MainClassName .. "/g' App.java && mv App.java " .. MainClassName .. ".java"
    end
    -- vim.api.nvim_command(':!' .. command .. ' && cd ' .. artifactId .. ' && ' .. addPropertiesCommand  .. ' && ' .. addBuildCommand .. renameMainClass)
    vim.api.nvim_command(':!' .. command .. ' && cd ' .. artifactId .. ' && ' .. addPropertiesCommand .. renameMainClass)
  end,
  { force = true, nargs = 1 }
)

-- vim.api.nvim_create_user_command('JavaBuildAndRun',
--   ':term cd `(find $(pwd) -name java -type d | grep main/java || echo ${$(pwd)\\%java*}java) | grep main/java` && javac **/App.java && java **/App.java <cr>'
--   , opts)

vim.api.nvim_create_user_command(
  'MavenInstallDependencies',
  function()
    vim.api.nvim_command(':9TermExec open=0 cmd="mvn dependency:copy-dependencies"')
  end,
  {}
)

vim.api.nvim_create_user_command('JavaBuildAndRun',
  ':9TermExec cmd="mvn -q clean compile exec:java"'
  , options)

vim.api.nvim_create_user_command('JavaRunTests',
  ':9TermExec cmd="mvn -q test"'
  , options)


