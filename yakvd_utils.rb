# Key-Value database helpers

# Takes ClassName in camel-case and creates
# snake-case representation
def underscore(camel_cased_word)
  result = camel_cased_word.to_s.gsub(/::/, '/')
  result = result.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
  result = result.gsub(/([a-z\d])([A-Z])/,'\1_\2')
  result.tr("-", "_").downcase
end