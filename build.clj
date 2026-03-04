(require '[clojure.string :as str])
(require '[flower.reflect :as reflect])
(require '[flower.fs :as fs])
(require '[expressions.default-build :as builder])
(require '[expressions.utils :refer [merge-deep]])
(require 'expressions.ninja)

(def css-files (fs/glob "static" "**.css"))

(def css-plan
  {:rules
   [{:name "lightningcss"
     :command "lightningcss --minify --bundle --targets \">= 0.25%\" $in -o $out"
     :description "minify $in with Lightning CSS"}]
   :builds
   (map (fn [f]
          {:rule "lightningcss"
           :inputs (str f)
           :outputs (str "public/" (str/replace (str f) #"^static/" ""))})
        css-files)})

(def default-plan (builder/default-build-plan))

; Remove the default link rules for CSS files so they don't conflict
(def filtered-plan
  (update default-plan :builds
    (fn [builds]
      (remove (fn [b]
                (and (= (:rule b) "link")
                     (str/ends-with? (str (:inputs b)) ".css")))
              builds))))

(reflect/write-ninja! (expressions.ninja/generate (merge-deep filtered-plan css-plan)))
