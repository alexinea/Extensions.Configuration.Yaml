using System.IO;
using Microsoft.Extensions.Configuration;

namespace Alexinea.Extensions.Configuration.Yaml {
    /// <summary>
    /// Loads configuration key/values from a yaml stream into a provider.
    /// </summary>
    public class YamlStreamConfigurationProvider : StreamConfigurationProvider {
        /// <summary>
        /// Constructor.
        /// </summary>
        /// <param name="source">The <see cref="YamlStreamConfigurationSource"/>.</param>
        public YamlStreamConfigurationProvider(YamlStreamConfigurationSource source) : base(source) { }

        /// <summary>
        /// Loads json configuration key/values from a stream into a provider.
        /// </summary>
        /// <param name="stream">The json <see cref="Stream"/> to load configuration data from.</param>
        public override void Load(Stream stream) {
            Data = YamlConfigurationFileParser.Parse(stream);
        }
    }
}