using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.Extensions.Configuration;
using YamlDotNet.Core;

namespace Alexinea.Extensions.Configuration.Yaml {
    /// <summary>
    /// A Yaml file based <see cref="FileConfigurationProvider"/>.
    /// </summary>
    public class YamlConfigurationProvider : FileConfigurationProvider {

        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="source">The <see cref="YamlConfigurationSource"/>.</param>
        public YamlConfigurationProvider(YamlConfigurationSource source) : base(source) { }

        /// <summary>
        /// Loads yaml configuration key/values from a stream into a provider.
        /// </summary>
        /// <param name="stream">The yaml <see cref="Stream"/> to load configuration data from.</param>
        public override void Load(Stream stream) {
            try {
                Data = YamlConfigurationFileParser.Parse(stream);
            }
            catch (YamlException ex) {
                string errorLine = string.Empty;
                if (stream.CanSeek) {
                    stream.Seek(0, SeekOrigin.Begin);

                    using (var streamReader = new StreamReader(stream)) {
                        var fileContent = ReadLines(streamReader);
                        errorLine = RetrieveErrorContext(ex, fileContent);
                    }
                }

                throw new FormatException(
                    "Could not parse the YAML file. " +
                    $"Error on line number '{ex.Start.Line}': '{errorLine}'.", ex);
            }
        }

        private static string RetrieveErrorContext(YamlException ex, IEnumerable<string> fileContent) {
            var possibleLineContent = fileContent.Skip(ex.Start.Line - 1).FirstOrDefault();
            return possibleLineContent ?? string.Empty;
        }

        private static IEnumerable<string> ReadLines(StreamReader streamReader) {
            string line;
            do {
                line = streamReader.ReadLine();
                yield return line;
            } while (line != null);
        }
    }
}