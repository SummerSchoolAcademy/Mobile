package com.dd.summerschool.ui.details

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.dd.summerschool.R
import com.dd.summerschool.data.UniversitiesRepository
import com.dd.summerschool.databinding.FragmentDetailsBinding
import com.dd.summerschool.ext.setImageFromAsset

/**
 * A simple [Fragment] subclass.
 */
class DetailsFragment : Fragment() {

    private val fallbackId: String = "5E7A2E3B-366B-4B06-8BA9-31AC87D339EA"
    private val universitiesRepo: UniversitiesRepository = UniversitiesRepository
    private lateinit var binding: FragmentDetailsBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        binding = FragmentDetailsBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val itemId = arguments?.getString(ITEM_ID) ?: fallbackId
        val university = universitiesRepo.getById(itemId)
        binding.apply {
            imageLarge.setImageFromAsset(university.image)
            name.text = university.name
            year.text = resources.getString(R.string.university_item_year_format, university.year)
            city.text = resources.getString(R.string.university_item_city_format, university.city)
            description.text = university.description
            checkFavourite.isChecked = university.favourite
            checkFavourite.setOnCheckedChangeListener { buttonView, isChecked ->
                universitiesRepo.updateFavourite(university.id, isChecked)
            }
        }

    }

    companion object {
        const val ITEM_ID = "itemId"
    }
}