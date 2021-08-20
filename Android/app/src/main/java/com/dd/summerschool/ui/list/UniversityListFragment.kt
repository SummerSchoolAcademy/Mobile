package com.dd.summerschool.ui.list

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.RecyclerView
import com.dd.summerschool.R
import com.dd.summerschool.data.UniversitiesRepository
import com.dd.summerschool.databinding.FragmentUniversityListBinding
import com.dd.summerschool.model.University
import com.dd.summerschool.ui.details.DetailsFragment.Companion.ITEM_ID

/**
 * A fragment representing a list of Items.
 */
class UniversityListFragment : Fragment(), UniversityItemListener {

    private lateinit var binding: FragmentUniversityListBinding
    private val universitiesRepo: UniversitiesRepository = UniversitiesRepository
    private val universitiesAdapter = UniversitiesAdapter(this)

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        setHasOptionsMenu(true)
        binding = FragmentUniversityListBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        //1. set views
        binding.recyclerView.apply {
            addItemDecoration(DividerItemDecoration(context, RecyclerView.VERTICAL))
            adapter = universitiesAdapter
        }

        //2. load data
        universitiesRepo.loadData(resources.assets)

        //3. observe data
        universitiesRepo.observeData(viewLifecycleOwner, object : Observer<List<University>> {
            override fun onChanged(list: List<University>?) {
                if (list != null) {
                    universitiesAdapter.submitList(list)
                }
            }
        })
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.menu_fav, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.fav_filter -> universitiesRepo.toggleFilter()
        }
        return super.onOptionsItemSelected(item)
    }

    override fun onDestroy() {
        super.onDestroy()
        universitiesRepo.clearData()
    }

    override fun onItemFavourite(itemId: String, on: Boolean) {
        universitiesRepo.updateFavourite(itemId, on)
    }

    override fun onItemTap(itemId: String) {
        findNavController().navigate(
            R.id.action_universityListFragment_to_detailsFragment,
            Bundle().apply {
                putString(ITEM_ID, itemId)
            })
    }
}